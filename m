From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>
Subject: Re: System no longer responds to magic packets after power down.
Date: Wed, 3 Dec 2003 19:24:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031203182456.GB28870@tate.loria.fr>
References: <Pine.LNX.4.10.10312010214310.13819-100000@vengeance.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10312010214310.13819-100000-4V0eaZAy+Mi7Qac5JyVuKSvJykC1LJ6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


You probably need the wakeup_enable patch (attached). No guarantees
though.

I have this patch on my hard drive, but I absolutely can't remember who
wrote it, and where I've gotten it (maybe linux-kernel). Does anyone
know who is the person to be credited for this patch ?

E.

On Mon, Dec 01, 2003 at 02:34:24AM +0100, Arjen Verweij wrote:
> Hi,
> 
> I have a machine with an abit nf7-s motherboard in it. Debian sid runs
> nicely on it, with a 2.4.22 kernel. There is a rather peculiar quirk with
> Wake-on-LAN though. After power down from Linux, the box will no longer
> respond to magic packets. This is only the case with power down from
> Linux, and not from Windows. In order to be able to wake the box up again,
> I have to power on/off the box.
> 
> I suppose something gets reset then, but I don't know what it is. Does
> anyone have a clue where the problem might be? Personallly I think it
> could be either ACPI or the binary driver from nvidia, although I don't
> have a clue how the latter would waste the WOL function. It is just an
> observation that the driver in W2K can detect if WOL is enabled or not.
> Maybe it can turn it off as well?
> 
> To exclude the nvidia driver as the culprit, I tried to boot without the
> nvnet module, shutdown and ether-wake. No dice. So now I am wondering
> about ACPI.
> 
> The 2.4.22 kernel is vanilla, no patches applied. Should I file a
> bugreport as described on the project pages?
> 
> Thanks for your effort.
> 
> Regards,
> 
> Arjen
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--6sX45UoQRIJXqkqR
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="wakeup.patch.gz"
Content-Transfer-Encoding: base64

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

--6sX45UoQRIJXqkqR--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
