From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: libata Promise driver regression 2.6.5->2.6.6
Date: Tue, 18 May 2004 13:19:01 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40AA4585.4060301@pobox.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com> <1084820518.12349.347.camel@dhcppc4> <40A90EE2.3040507@wasp.net.au> <40A91410.5040408@pobox.com> <40AA3844.9010403@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40AA3844.9010403-UPaTOFvTz1K6c6uEtOJ/EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brad Campbell <brad-UPaTOFvTz1K6c6uEtOJ/EA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Brad Campbell wrote:
> Jeff Garzik wrote:
>  > The attached patch, against kernel 2.6.5, updates libata to the code
>  > that is found in kernel 2.6.6.
> 
> Yep, see the attached dmesg.. problem followed the libata code :p(
> 
> All I did was a cp -av on my 2.6.5 tree, applied your patch, added a 
> -testbk to the Makefile, did a
> make oldconfig && make && make modules_install && reboot
> 
> Hangs for a while at the end and then spits out a dma timeout, never to 
> recover.
> 
> my grub entry was a direct copy of the 2.6.5 one with -test added to it.


Interesting.

Well since it's not global behavior, but isolated to one port or card, I 
still worry about non-libata things:
1) is a SATA cable bad, or not plugged in well?  I'm finding that it's 
easier to screw up SATA cabling than PATA.  It's more-convenient design 
is also less rugged.
2) is a PCI slot bad, or not busmastering like it should?  have you 
tried moving the card to another PCI slot?
3) is it always the 9th port, regardless of the ordering of the PCI 
cards in PCI slots?

I apologize if you answered some of these in a previous message.

	Jeff





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
