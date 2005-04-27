From: "Joe Julian" <joe-Fcm6T8Fmt17HuhbChzYfaQ@public.gmane.org>
Subject: RE: AC Disconnect bug
Date: Tue, 26 Apr 2005 21:59:46 -0700
Message-ID: <001101c54ae5$f2007690$6901a8c0@questor>
References: <16A54BF5D6E14E4D916CE26C9AD3057501CDFCD5@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057501CDFCD5-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Li, Shaohua'" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "'Yu, Luming'" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Was RE: [ACPI] Why do I have to set pci=noacpi for network card to work?

I'm far from being an expert, but I don't think so. I've got debug enabled
and I don't get any errors at all. From what I could find in my searches,
the EC GPE errors even show up in the logs. ec.c is loaded with printks.
With the race condition, the system comes to a grinding halt. The kernel's
so busy swapping that there's not enough cpu cycles to even flush the disk
cache, so I've stopped syslogd and set dmesg -n8 to get the debug on the
console to no avail. There are no kernel messages at all that occur when
this problem does (which makes it very difficult to guess where it's
happening).

> -----Original Message-----
> From: Li, Shaohua [mailto:shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org] 
> Sent: Tuesday, April 26, 2005 9:19 PM
> To: Joe Julian; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Yu, Luming
> Subject: RE: [ACPI] Why do I have to set pci=noacpi for 
> network card to work?
> 
> 
> >So does that mean that if a dsdt file won't compile that the bios is 
> >inherently broken?
> No. Some errors can be workaround.
> 
> >
> >I've been trying to track down a race condition on my notebook that
> makes
> >the kernel allocate all memory when I unplug the AC adapter, and in
> trying
> >to learn how acpi works I looked at the DSDT and found all kinds of
> errors
> >and warnings when trying to compile it.
> It maybe the EC GPE issue. Luming is working on it.
> 
> Thanks,
> Shaohua
> 
> 



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
