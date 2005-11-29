From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: asus_acpi oops on samsung p35
Date: Tue, 29 Nov 2005 10:09:16 +0100
Message-ID: <1133255356.25720.19.camel@linux.site>
References: <200511212038.39593.saschasommer@freenet.de>
	 <200511251443.19125.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200511251443.19125.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sascha Sommer <saschasommer-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, 2005-11-25 at 14:43 +0800, Yu, Luming wrote:

> On Tuesday 22 November 2005 03:38, Sascha Sommer wrote:
> > Hi,
> >
> > as the oops, reported for example in
> > http://sourceforge.net/mailarchive/message.php?msg_id=11977633,
> > is still occuring on recent kernels it would be nice if someone could
> > review the attached patch from Christian Aichinger posted to this list in
> > http://sourceforge.net/mailarchive/message.php?msg_id=13057151
> > so the remaining issues can be fixed.
> > It is working fine with my Samsung p35.
> 
> One question:  why you need asus_acpi.c ?
> 
> Does striking hotkeys on keyboard works for you?
> Do you need to echo something to proc files
> for hotkey function?

Please include the fix as asus_acpi.c is still part of the mainline
kernel.

The fix is extensively tested.  I've included a similar patch for SL
10.0 and had positive feedback of Samsung P3x users.  It did not bear
any side effects.

> Thanks,
> Luming

Thanks,

   Timo



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
