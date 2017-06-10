require 'test_helper'
require 'motorsports'

class ArchiveHandlerTest < Minitest::Test
  def setup
    @unarchived_data = Motorsports::ArchiveHandler.unarchive(archive_path)
  end

  def test_unarchive_returns_the_first_csv_of_given_archive
    assert @unarchived_data
  end

  def test_unarchive_returns_nil_if_no_csv_is_found
    assert_nil Motorsports::ArchiveHandler.unarchive(no_csv_archive_path)
  end

  def test_unarchive_saves_file_with_specific_name_under_tmp_dir
    assert File.exist?(new_csv_file)
  end

  private

  def archive_path
    File.expand_path('test/example_zip/Archive.zip')
  end

  def no_csv_archive_path
    File.expand_path('test/example_zip/NoCsvArchive.zip')
  end

  def new_csv_file
    File.expand_path('tmp/canada_parts_data.new.csv')
  end
end
