From: =?iso-8859-1?q?Mica=20Telodico?= <maria_libera2000-whZMOeQn8C0@public.gmane.org>
Subject: Re: _CRS returns NULL!  message , problems?
Date: Sat, 6 Mar 2004 19:12:02 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040306181202.53992.qmail@web41904.mail.yahoo.com>
References: <1078554200.12991.3193.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-614831061-1078596722=:53945"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1078554200.12991.3193.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--0-614831061-1078596722=:53945
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ok, got it .

Anyway on my system seems to work all the levels of ACPI Sleep . 
Thanks for your explanation .
 
Marcello

Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
just ignore it.

note a great indicator of quality, but this particular warning message
is benign.

cheers,
-Len

On Thu, 2004-03-04 at 14:13, Mica Telodico wrote:
> 
> Sorry for the late answer .
> 
> So , my BIOS has a little fault? I may have problems in the future?
> It's an important fault or just something that you can skip over?
> 
> This motherboard is new , and I wouldn't like to know to have done a
> bad buy :-( 
> 
> Thanks marcello
> 
> Len Brown wrote: 
> On Sun, Feb 29, 2004 at 02:49:42PM +0100, Mica
> Telodico wrote:
> > Hi all,
> > 
> > I'm the owner of a Abit KV7 Motherboard (VIA KT600),
> > and I get these messages at the boot time :
> > 
> > _CRS returns NULL! Using IRQ 21 fordevice (PCI
> ...
> > 
> > what do mean those _CRS returns NULL! ?
> > 
> > Does this message means problems with some hardware?
> 
> sub-standard BIOS, but non-fatal error.
> it is on my list to hide this error with !acpi_force
> -- thanks for the reminder.
> 
> 
> Sorry
> 
> 
> 
> 
> ______________________________________________________________________
> Yahoo! Mail: 6MB di spazio gratuito, 30MB per i tuoi allegati,
> l'antivirus, il filtro Anti-spam



---------------------------------
Yahoo! Mail: 6MB di spazio gratuito, 30MB per i tuoi allegati, l'antivirus, il filtro Anti-spam
--0-614831061-1078596722=:53945
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Ok, got it .</DIV>
<DIV><BR>Anyway on my system seems to work all the levels of ACPI Sleep . </DIV>
<DIV>Thanks for your explanation .</DIV>
<DIV>&nbsp;</DIV>
<DIV>Marcello</DIV>
<DIV><BR><B><I>Len Brown &lt;len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">just ignore it.<BR><BR>note a great indicator of quality, but this particular warning message<BR>is benign.<BR><BR>cheers,<BR>-Len<BR><BR>On Thu, 2004-03-04 at 14:13, Mica Telodico wrote:<BR>&gt; <BR>&gt; Sorry for the late answer .<BR>&gt; <BR>&gt; So , my BIOS has a little fault? I may have problems in the future?<BR>&gt; It's an important fault or just something that you can skip over?<BR>&gt; <BR>&gt; This motherboard is new , and I wouldn't like to know to have done a<BR>&gt; bad buy :-( <BR>&gt; <BR>&gt; Thanks marcello<BR>&gt; <BR>&gt; Len Brown <LENB-B9hJ7EM+n05kvSR1tTvMeSFgAB7YVZ25Wf50MzlI8c4@public.gmane.org>wrote: <BR>&gt; On Sun, Feb 29, 2004 at 02:49:42PM +0100, Mica<BR>&gt; Telodico wrote:<BR>&gt; &gt; Hi all,<BR>&gt; &gt; <BR>&gt; &gt; I'm the owner of a Abit KV7 Motherboard (VIA KT600),<BR>&gt; &gt; and
  I get these messages at the boot time :<BR>&gt; &gt; <BR>&gt; &gt; _CRS returns NULL! Using IRQ
 21 fordevice (PCI<BR>&gt; ...<BR>&gt; &gt; <BR>&gt; &gt; what do mean those _CRS returns NULL! ?<BR>&gt; &gt; <BR>&gt; &gt; Does this message means problems with some hardware?<BR>&gt; <BR>&gt; sub-standard BIOS, but non-fatal error.<BR>&gt; it is on my list to hide this error with !acpi_force<BR>&gt; -- thanks for the reminder.<BR>&gt; <BR>&gt; <BR>&gt; Sorry<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; ______________________________________________________________________<BR>&gt; Yahoo! Mail: 6MB di spazio gratuito, 30MB per i tuoi allegati,<BR>&gt; l'antivirus, il filtro Anti-spam<BR></BLOCKQUOTE><p><br><hr size=1><A HREF="http://it.yahoo.com/mail_it/foot/?http://it.mail.yahoo.com/"><b>Yahoo! Mail</a></b>: 6MB di spazio gratuito, 30MB per i tuoi allegati, l'antivirus, il filtro Anti-spam
--0-614831061-1078596722=:53945--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
