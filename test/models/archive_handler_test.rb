require 'test_helper'

class ArchiveHandlerTest < ActiveSupport::TestCase
  def setup
    @unarchived_data = ArchiveHandler.unarchive(archive_path)
  end

  test ".unarchive returns the first csv file of the archive" do
    assert @unarchived_data
  end

  test ".unarchive returns nil if no csv is found" do
    assert_nil ArchiveHandler.unarchive(no_csv_archive_path)
  end

  test ".unarchive saves file with specific name under tmp dir" do
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
