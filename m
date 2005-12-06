From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: git pull on Linux/ACPI release tree
Date: Tue, 6 Dec 2005 03:17:50 -0500
Message-ID: <200512060317.53925.len.brown@intel.com>
References: <200512010305.43469.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200512010305.43469.len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: torvalds-3NddpPZAyC0@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the file shown below.

thanks!

-Len

 drivers/acpi/processor_idle.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

through these commits:

David Shaohua Li:
      [ACPI] correct earlier SMP deep C-states on HT patch

with this log:

commit 927fe18397b3b1194a5b26b1d388d97e391e5fd2
Merge: e4f5c82a92c2a546a16af1614114eec19120e40a 
1e483969930a82e16767884449f3a121a817ef00
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Mon Dec 5 17:08:40 2005 -0500

    Pull 5165 into release branch

commit 1e483969930a82e16767884449f3a121a817ef00
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Dec 1 17:00:00 2005 -0500

    [ACPI] correct earlier SMP deep C-states on HT patch
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5165
    
    Change polarity of test for PLVL2_UP flag.
    Skip promotion/demotion code when not needed.
    
    Signed-off-by: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
