From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: [PATCH] PNPACPI parser fix
Date: Fri, 04 Feb 2005 18:24:21 +0100
Message-ID: <4203AFC5.8070308@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090901030501080108010706"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901030501080108010706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch is very old (11/2004), but never get merged even if acked by 
Shaohua Li.
As you can see in the bugzilla report 
(http://bugzilla.kernel.org/show_bug.cgi?id=3912), it solve parsing 
issue in the pnpacpi core : the pnpacpi parser supposed that are no
resource after EndDependentFn.

Please apply this patch.
Thanks.

Matthieu CASTET

--------------090901030501080108010706
Content-Type: text/x-patch;
 name="pnpacpi_parser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_parser.patch"

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head><!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org --><!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org --><title>Bug 3912 - pnpacpi rsparser bug</title>
    
    

<link rel="First" href="http://bugzilla.kernel.org/show_bug.cgi?id=3295">
<link rel="Prev" href="http://bugzilla.kernel.org/show_bug.cgi?id=3295">
<link rel="Up" href="http://bugzilla.kernel.org/buglist.cgi?regetlastlist=1">
<link rel="Contents" href="http://bugzilla.kernel.org/buglist.cgi?regetlastlist=1">

    
    
    
  <link rel="SHORTCUT ICON" href="http://bugme.osdl.org//images/favicon.png"></head>








  <body onload="" bgcolor="#ffffff">


<!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org -->




    <table bgcolor="#000000" border="0" cellpadding="0" cellspacing="0" width="100%">
                   <tbody>
      <tr>
<td bgcolor="#ffffff" height="75" valign="top" width="153"><a href="http://www.osdl.org/"><img src="pnpacpi_parser_files/osdl-logo1.jpg" alt="www.osdl.org" height="75" width="153">
      </a>        <br>
        </td>
        <td>
          <center><font color="#ffffff" size="8">
            Kernel Bug Tracker
        </font></center></td>
      </tr>

      </tbody>
    </table>

    <table border="0" cellspacing="0">
      <tbody><tr>
        <td align="left" valign="top">
          <table border="0" cellpadding="0" cellspacing="2">
            <tbody><tr>
              <td align="left" nowrap="nowrap" valign="top">
                <font size="+1"><b>Bugzilla Bug 3912</b></font>
              </td>
            </tr>
          </tbody></table>
        </td>
        <td valign="middle">&nbsp;</td>
        <td align="left" valign="middle">pnpacpi rsparser bug</td>
      </tr>
    </tbody></table>
<!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org -->


  <b>Bug List:</b>
    (2 of 2)
  
  <a href="http://bugzilla.kernel.org/show_bug.cgi?id=3295">First</a>
  <a href="http://bugzilla.kernel.org/show_bug.cgi?id=3912">Last</a>

      <a href="http://bugzilla.kernel.org/show_bug.cgi?id=3295">Prev</a>

      <i><font color="#777777">Next</font></i>
  
  &nbsp;&nbsp;<a href="http://bugzilla.kernel.org/buglist.cgi?regetlastlist=1">Show list</a>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://bugzilla.kernel.org/query.cgi">Query page</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://bugzilla.kernel.org/enter_bug.cgi">Enter new bug</a>

<hr>

<form name="changeform" method="post" action="process_bug.cgi">

  <input name="delta_ts" value="20041217083150" type="hidden">
  <input name="longdesclength" value="2" type="hidden">
  <input name="id" value="3912" type="hidden">



  <input name="priority" value="P2" type="hidden">

    <input name="bug_file_loc" value="" type="hidden">

  <table border="0" cellpadding="1" cellspacing="1">
    <tbody><tr>      
      <td align="right">
        <b>Bug#:</b>
      </td>
      <td>
        <a href="http://bugme.osdl.org/show_bug.cgi?id=3912">3912</a>
      </td>
      
      <td>&nbsp;</td>


      
      <td align="right">
        <b>Submitter:</b>
      </td>
      <td>castetm-UaJNOkYSdu/AxSv9cyjLgA@public.gmane.org (CASTET Matthieu)
      </td>    
    </tr>
    
    <tr>
      <td align="right">
        <b><a href="http://bugzilla.kernel.org/bug_status.html#category">Category</a>:</b>
      </td><td>
    <select name="product"><option value="ACPI" selected="selected">ACPI
        </option><option value="Alternate Trees">Alternate Trees
        </option><option value="Drivers">Drivers
        </option><option value="File System">File System
        </option><option value="IO/Storage">IO/Storage
        </option><option value="Memory Management">Memory Management
        </option><option value="Networking">Networking
        </option><option value="Other">Other
        </option><option value="Platform Specific/Hardware">Platform Specific/Hardware
        </option><option value="Power Management">Power Management
        </option><option value="Process Management">Process Management
        </option><option value="Timers">Timers
        </option></select>
  </td>
  <td>&nbsp;</td>
      



    </tr>

    

    <tr>
      <td align="right">
        <b>
          <a href="http://bugzilla.kernel.org/describecomponents.cgi?product=ACPI">
            Component</a>:
        </b>
      </td>
      <td>
        <select name="component"><option value="AML-Interpreter">AML-Interpreter
            </option><option value="BIOS">BIOS
            </option><option value="Config-Hotplug">Config-Hotplug
            </option><option value="Config-Interrupts">Config-Interrupts
            </option><option value="Config-Other">Config-Other
            </option><option value="Config-Processors">Config-Processors
            </option><option value="Config-Tables">Config-Tables
            </option><option value="Other" selected="selected">Other
            </option><option value="Power-Battery">Power-Battery
            </option><option value="Power-Fan">Power-Fan
            </option><option value="Power-Off">Power-Off
            </option><option value="Power-Other">Power-Other
            </option><option value="Power-Processor">Power-Processor
            </option><option value="Power-Sleep-Wake">Power-Sleep-Wake
            </option><option value="Power-Thermal">Power-Thermal
            </option><option value="Power-Video">Power-Video
            </option></select>
      </td>

      <td>&nbsp;</td>
 
      <td align="right">
        <b>Add&nbsp;CC:</b>
      </td>
      <td>
        <input name="newcc" size="30" value="">
      </td>
            <td>&nbsp;</td>

    </tr>
    
    <tr>
      <td align="right">
        <b>
          <a href="http://bugzilla.kernel.org/bug_status.html#version">Kernel Version</a>:
        </b>
      </td>
      <td><input name="kernel_version" value="2.6.10rc2" size="32"></td>
      <td></td>
      <td rowspan="4" align="right" valign="top">
        <b>CC:</b>
      </td>
      <td rowspan="4" valign="top"> 
        <input name="cc" value="" type="hidden">
      </td>

    </tr>

    <tr>
      <td align="right">
        <b>
          <a href="http://bugzilla.kernel.org/bug_status.html">Status</a>:
        </b>
      </td>
      <td>RESOLVED</td>      
      <td>&nbsp;</td>

	  </tr>
    
    <tr>
      <td align="right">
        <b>
          <a href="http://bugzilla.kernel.org/bug_status.html">Resolution</a>:
        </b>
      </td>
      <td>CODE_FIX</td>      
      <td>&nbsp;</td>
      </tr>
      <tr><td align="right">
        <b><a href="http://bugzilla.kernel.org/bug_status.html#severity">Severity</a>:</b>
      </td><td>
    <select name="bug_severity"><option value="blocking">blocking
        </option><option value="high" selected="selected">high
        </option><option value="normal">normal
        </option><option value="low">low
        </option></select>
  </td>
  <td>&nbsp;</td>
      
    </tr>
    
    <tr>
      <td align="right">
        <b>
          <a href="http://bugzilla.kernel.org/bug_status.html#assigned_to">Owner</a>:
        </b>
      </td>
      <td>acpi_other-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org</td>
      <td>&nbsp;</td>
 
        <td colspan="3">&nbsp;</td>
    </tr>




  <tr>
    <td align="right">
      <b>Summary:</b>
    </td>
    <td colspan="7">
      <input name="short_desc" value="pnpacpi rsparser bug" size="60">
    </td>
  </tr>


  </tbody></table>
  

<!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org -->


<br>
<table border="1" cellpadding="4" cellspacing="0">
  <tbody><tr>
    <th align="left" bgcolor="#cccccc">Attachment</th>
    <th align="left" bgcolor="#cccccc">Type</th>
    <th align="left" bgcolor="#cccccc">Modified</th>
    <th align="left" bgcolor="#cccccc">Status</th>
    <th align="left" bgcolor="#cccccc">Actions</th>
  </tr>

    <tr>
      <td valign="top">
          <a href="http://bugzilla.kernel.org/attachment.cgi?id=4275&amp;action=view">patch that correct the bug</a> 
      </td>

      <td valign="top">
          <i>patch</i>
      </td>

      <td valign="top">2004-12-17 08:30</td>

      <td valign="top">
          <i>none</i>
      </td>

      <td valign="top">
          <a href="http://bugzilla.kernel.org/attachment.cgi?id=4275&amp;action=edit">Edit</a>
      </td>
    </tr>

  <tr>
    <td colspan="4">
      <a href="http://bugzilla.kernel.org/attachment.cgi?bugid=3912&amp;action=enter">Create a New Attachment</a> (url, proposed patch, testcase, etc.)
    </td>
    <td colspan="1">
      <a href="http://bugzilla.kernel.org/attachment.cgi?bugid=3912&amp;action=viewall">View All</a>
    </td>
  </tr>
</tbody></table>
<br>



  <table>
    <tbody><tr><th align="right">Bug 3912 depends on:</th>
  <td>
  </td>
  <td>
    <input name="dependson" value="">
  </td>
      <td rowspan="2">
        <a href="http://bugzilla.kernel.org/showdependencytree.cgi?id=3912">Show 
        dependency tree</a>  
  
          <br>
          <a href="http://bugzilla.kernel.org/showdependencygraph.cgi?id=3912">Show 
          dependency graph</a>
      </td>
    </tr>

    <tr><th align="right">Bug 3912 blocks:</th>
  <td>
  </td>
  <td>
    <input name="blocked" value="">
  </td>
    </tr>
  </tbody></table>




  <br>
  <b>Additional Comments:</b>
  <br>
  <textarea wrap="hard" name="comment" rows="10" cols="80" accesskey="c"></textarea>
  <br>




  <br>
  <input name="knob" value="none" checked="checked" type="radio">
  Leave as <b>RESOLVED&nbsp;CODE_FIX</b>
  <br>




        <input name="knob" value="verify" type="radio">
        Mark bug as <b>VERIFIED</b> (the fix has been tested)<br>  
        <input name="knob" value="reopen" type="radio"> Reopen bug
        <br>
        <input name="knob" value="close" type="radio">
        Mark bug as <b>CLOSED</b><br>  

  <input value="Commit" type="submit">
  <input name="form_name" value="process_bug" type="hidden">
  <p>
    <font size="+1">
      <b>
        <a href="http://bugzilla.kernel.org/show_activity.cgi?id=3912">View Bug Activity</a>
        &nbsp; | &nbsp;
        <a href="http://bugzilla.kernel.org/long_list.cgi?buglist=3912">Format For Printing</a>
      </b>
    </font>

  </p>  
</form>



<table>
  <tbody><tr>
    <td align="left">
      <b>
        <a name="c0" href="#c0">Description</a>:
      </b>
    </td>
    <td align="right" width="100%">
      Opened: 2004-12-17 08:28 Last update: 2004-12-17 08:31
  </td></tr>
</tbody></table>
<hr>
<!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org -->

<pre>The possible resource are not well parsed. See :
<a href="http://marc.theaimsgroup.com/?l=linux-kernel&amp;m=110106097404193&amp;w=2">http://marc.theaimsgroup.com/?l=linux-kernel&amp;m=110106097404193&amp;w=2</a></pre>
  <br>
    <i>------- Additional Comment
      <a name="c1" href="#c1">#1</a> From 
      <a href="mailto:castetm-UaJNOkYSdu/AxSv9cyjLgA@public.gmane.org">CASTET Matthieu</a>
      2004-12-17 08:30 -------
    </i>
    

<pre><a href="http://bugzilla.kernel.org/attachment.cgi?id=4275&amp;action=view">Created an attachment (id=4275)</a>
patch that correct the bug

Parse indep option if there are after dependant options.

It will also report error if the _PRS returned by BIOS has bug (multiple 'end
of resources').</pre>
  
<hr>
<!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org -->


  <b>Bug List:</b>
    (2 of 2)
  
  <a href="http://bugzilla.kernel.org/show_bug.cgi?id=3295">First</a>
  <a href="http://bugzilla.kernel.org/show_bug.cgi?id=3912">Last</a>

      <a href="http://bugzilla.kernel.org/show_bug.cgi?id=3295">Prev</a>

      <i><font color="#777777">Next</font></i>
  
  &nbsp;&nbsp;<a href="http://bugzilla.kernel.org/buglist.cgi?regetlastlist=1">Show list</a>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://bugzilla.kernel.org/query.cgi">Query page</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://bugzilla.kernel.org/enter_bug.cgi">Enter new bug</a>

<br>
<!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org -->



  

  
<table border="0">
  <tbody><tr>
    <td bgcolor="#000000" valign="top">
      <table bgcolor="lightyellow" border="0" cellpadding="10" cellspacing="0" width="100%">
        <tbody><tr>
          <td>
          


<!-- 1.0-590EEB7GvNhg9hUCZPvPmw@public.gmane.org -->






<form method="get" action="show_bug.cgi">
  <table width="100%">
    <tbody><tr>
      <td>
        Actions:
      </td>
      
      <td nowrap="nowrap" valign="middle">
        <a href="http://bugzilla.kernel.org/enter_bug.cgi">New</a> | 
        <a href="http://bugzilla.kernel.org/query.cgi">Query</a> |
        
        <input value="Find" type="submit"> bug # 
        <input name="id" size="6"> | 
        
        <a href="http://bugzilla.kernel.org/reports.cgi">Reports</a> 
             
      </td>

      <td>&nbsp;</td>
       

      <td valign="middle">
        Edit <a href="http://bugzilla.kernel.org/userprefs.cgi">prefs</a>

        | <a href="http://bugzilla.kernel.org/relogin.cgi">Log&nbsp;out</a>&nbsp;castetm-UaJNOkYSdu/AxSv9cyjLgA@public.gmane.org
      </td>
    </tr> 

    
    
      
    <tr>
        <td>
          Preset&nbsp;Queries:
        </td>
      
      <td colspan="3">
          <a href="http://bugzilla.kernel.org/buglist.cgi?bug_status=NEW&amp;bug_status=ASSIGNED&amp;email1=castetm%40ensimag.imag.fr&amp;emailtype1=exact&amp;emailassigned_to1=1&amp;emailreporter1=1">My&nbsp;Bugs</a>

      </td>
    </tr>
      
    
  </tbody></table>                
</form>


 
           This is based on <b>Bugzilla</b>: the Mozilla bug system.  For more 
            information about what Bugzilla is and what it can do, see 
            <a href="http://www.bugzilla.org/">bugzilla.org</a>.
<br><small>Bugzilla version 2.16.6</small>            


          </td>
        </tr>
      </tbody></table>
    </td>
  </tr>
</tbody></table>

</body></html>
--------------090901030501080108010706--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
