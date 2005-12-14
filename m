From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
Date: Tue, 13 Dec 2005 21:15:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512132104140.4184@g5.osdl.org>
References: <4395D945.6080108@gmx.net> <20051206192136.GA22615@kroah.com>
 <4395F0AB.1080408@gmx.net> <20051208033841.GA25008@kroah.com> <439A23CB.50102@gmx.net>
 <439FA436.50107@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <439FA436.50107-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



On Wed, 14 Dec 2005, Carl-Daniel Hailfinger wrote:
> 
> The patch has been tested and verified, is shipped in the
> SUSE 10.0 kernel and does not cause any regressions.

I'd be _much_ happier if

 - the patch wasn't totally whitespace-damaged (your mailer seems 
   to not only remove spaces at the end of lines, it _also_ adds them to 
   the beginning when there was another space there, as far as I can tell)

   Being right "on average" thanks to having two different bugs does not a 
   good mailer make.

 - you were to separate out the oops-fixing code from the code that adds 
   handling for that (strange?) model type logic.

   It seems that the _oops_ is because the later paths just assume that 
   it's a ACPI_TYPE_STRING and will dereference "model->string.pointer" 
   regardless of whether that is true or not. And you add a test for 
   ACPI_TYPE_INTEGER, however, you do _not_ fix the oops for any other 
   type, so the exact _same_ bug is still waiting to happen if there is 
   some other strange ACPI table entry some day.

So I think the proper fix is to _first_ just do something like

	if (model->type != ACPI_TYPE_STRING)
		goto unknown;

which should fix the oops (no?), and then handling ACPI_TYPE_INTEGER above 
that as one case would be a separate patch.

		Linus


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
