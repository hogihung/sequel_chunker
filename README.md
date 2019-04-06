# README

Sequel Chunker is an extraction of some code we are using in one of our apps.
It is laid out here as a module but one could copy and paste the methods into
their own if they wished.


```
  # -------------------------------------------------------------------
  # EXAMPLE USUAGE:
  # -------------------------------------------------------------------
    nurny_id_qry = DB["select nurny_id from docker_nodes where name IN
                        (#{qry_in_clause})", qry_placeholders]

    qry_result = process_chunked_qry(dkr_container_list, nurny_id_qry)
    return nil unless qry_result.is_a?(Array) && !qry_result.empty?

    nurny_id = qry_result.first

  # -------------------------------------------------------------------

  # -------------------------------------------------------------------
  gem install sequel
  gem install sqlite3
   
  ➜  ruby irb
  2.5.3 :001 > require 'sequel'
   => true 
  2.5.3 :002 > require 'sqlite3'
   => true 
  2.5.3 :003 > require_relative 'sequel_chunker'
   => true 
  2.5.3 :004 > include SequelChunker
   => Object 
  2.5.3 :005 > CHUNK_LIMIT
   => 2 
  2.5.3 :006 > DB = Sequel.sqlite
   => #<Sequel::SQLite::Database: {:adapter=>:sqlite}> 
  2.5.3 :007 > qry_in_clause
   => ":p1,:p2" 
  2.5.3 :008 > qry_placeholders
   => {:p1=>:$p1, :p2=>:$p2} 
  2.5.3 :009 > nurny_id_qry = DB["select nurny_id from docker_nodes where name IN (#{qry_in_clause})", qry_placeholders]
   => #<Sequel::SQLite::Dataset: "select nurny_id from docker_nodes where name IN (`$p1`,`$p2`)"> 
  2.5.3 :010 > 
  # -------------------------------------------------------------------


  # -------------------------------------------------------------------
  # ANOTHER EXAMPLE - Larger Chunk Limit
  # -------------------------------------------------------------------
   ➜  ruby irb  
   2.5.3 :001 > require 'sequel'
    => true 
   2.5.3 :002 > require 'sqlite3'
    => true 
   2.5.3 :003 > require_relative 'sequel_chunker'
    => true 
   2.5.3 :004 > include SequelChunker
    => Object 
   2.5.3 :005 > CHUNK_LIMIT
    => 5 
   2.5.3 :006 > qry_in_clause
    => ":p1,:p2,:p3,:p4,:p5" 
   2.5.3 :007 > qry_placeholders
    => {:p1=>:$p1, :p2=>:$p2, :p3=>:$p3, :p4=>:$p4, :p5=>:$p5} 
   2.5.3 :008 > DB = Sequel.sqlite
    => #<Sequel::SQLite::Database: {:adapter=>:sqlite}> 
   2.5.3 :009 > nurny_id_qry = DB["select nurny_id from docker_nodes where name IN (#{qry_in_clause})", qry_placeholders]
    => #<Sequel::SQLite::Dataset: "select nurny_id from docker_nodes where name IN (`$p1`,`$p2`,`$p3`,`$p4`,`$p5`)"> 
   2.5.3 :010 > 
  # -------------------------------------------------------------------
```
