From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] swsusp and ac status
Date: Mon, 28 Jun 2004 08:13:00 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr992vyyr4evsfm@smtp.pacific.net.th>
References: <200406250701.i5P71GKC006204@fermat.unipv.it> <opr95d71ln4evsfm@smtp.pacific.net.th> <20040627222842.GB1816@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040627222842.GB1816-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Software Suspend - Mailing Lists <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 28 Jun 2004 00:28:42 +0200, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wr=
ote:

> Thus wrote Michael Frank:
>> Too bad, this implies that the AC module does not get reinitialized af=
ter
>> resume and I suspect that acpi core is broken on 2.6 in this regard.
>
> As far as I know, there is no need to reinitialize the AC module, as it
> does not cache the results -- upon read, it calls the appropriate _PSR
> method which is supposed to return the correct AC adapter state, as sim=
ple
> as it gets. This way, any problems would indicate a faulty BIOS.
> Best regards,
>

Sorry, the BIOS does not know about suspend.

Please consider It just booted cold and the resuming kernel
without any ACPI modules won't have touched the AC method.

----> Thus the BIOS is now in a post boot state, like before
	vmlinux starts on boot!

----> The resumed kernel is in the state it was upon suspend.

Therefor IMO cause is the kernel which was resumed and
continues to talk to the BIOS which is in a state quite different
than what it was pefore suspend...

I concur that the BIOS in this case may break, but as it worked
prior to suspend it cannot be blamed for not handling such abuse.

A simple solution is for the resumed kernel to  start talking to
BIOS as it would have on a normal boot, perhaps executing
just a subset of the init code.

If it also would disable all modules prior to suspend, it
would likely fix all problems eliminating the reuqirement
to unload ACPI modules....

Best Regards



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
