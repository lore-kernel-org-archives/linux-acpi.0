From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: a question and pmtest
Date: Mon, 9 Jun 2003 22:59:35 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <32855.4.64.196.31.1055224775.squirrel@www.osdl.org>
References: <3EE4C8F5.7070302@kuiki.net>
        <20030609111529.0a26dc32.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030609225935_37777"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030609111529.0a26dc32.rddunlap-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hachi-rIxVFxJalAJeoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_20030609225935_37777
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

> On Mon, 09 Jun 2003 12:50:45 -0500 Jonathan Steinert <hachi-rIxVFxJalAJeoWH0uzbU5w@public.gmane.org>
> wrote:
>
> | My main problem is that my dell inspiron 8200 w/ Nvidia GF4 go will not  |
> turn the LCD back on after it is turned off (either by LID event, or by  | a
> sleep state). I asked about this on the support list and they tried to  |
> blame it on XFree86, but I'm not running X (yet). So the first question  |
> is, how can would one debug this without pmtest or how can I fix pmtest? |

> | I saw a post earlier on the list saying that pmtest in the pmtools  |
> package is orphaned right now, and that it won't compile. However it  |
> seems to compile just fine with gcc-3.0 and 3.2, does this indicate a  |
> compiler bug? I've recompiled my entire kernel with both 3.0 and 3.2  | with
> no sideffects, but I need pmtest to try to fix the aformentioned  | problem.
> |
> | Sadly, even though it compiles... when I try to insmod it I get the  |
> following message:
> |
> | Error inserting 'pmtest.o': -1 Invalid module format
>
> You are using the 2.5 module tools (utils), right?
> How about trying 'insmod pmtest.ko' ?
> or is it not even building a (correct) 2.5 module?
>
> I don't know the status of pmtest.  Anyone else?

Make sure that you have the 2.5 module tools.

I fixed the pmtest Makefile so that it works with 2.4 and 2.5 kernels.
I checked it into CVS at sf.net/projects/acpi/ and I have attached
it here.  See the Makefile for how to use it.

> | and this message shows up in my syslog:
> |
> | No module found in object
> |
> | I've added the MODULE_AUTHOR/DESCRIPTION/LICENSE functions to the file  |
> before compilation, but am unknowing as to what else is missing. Does  |
> anyone have any time to shed any light on this problem? I've never done  |
> any kernel programming before, but am willing to learn if necessary. |
> | Thanks much for your time.
> |
> | --hachi
> |
> | Kernel 2.5.69 and 2.5.70, both with patched DSDT. All ACPI components  |
> built-in to the kernel. Currently running 2.5.70 compiled under gcc-3.2,  |
> no framebuffer, no x, acpid 1.0.2, email me for more if needed.

HTH.
> --
> ~Randy



------=_20030609225935_37777
Content-Type: application/octet-stream; name="Makefile"
Content-Disposition: attachment; filename="Makefile"
Content-Transfer-Encoding: base64

IyBtYWtlZmlsZSBmb3IgcG10ZXN0IGtlcm5lbCBtb2R1bGUKIyB1c2FnZToKIyBjZCAvcGF0aC90
by9rZXJuZWwvc291cmNlLyAmJiBtYWtlIFNVQkRJUlM9L3BhdGgvdG8vc291cmNlL3BtdGVzdC8g
YWxsCgphbGw6CXBtdGVzdC5vCgpvYmotbSA6PSBwbXRlc3QubwoKY2xlYW4tZmlsZXMgOj0gKi5v
ICoua28gKi5tb2QuYwo=

------=_20030609225935_37777--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
