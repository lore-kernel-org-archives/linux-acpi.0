From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: CALL FOR TESTING
Date: Fri, 20 Sep 2002 10:56:21 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE96@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'berndp=p32f3XyCuykqcZcGjlUOXw@public.gmane.org'" <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Bernd Pfrommer [mailto:berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org] 
> kernel: 2.4.20-pre7, with patch acpi20020918, configured with ACPI
> platform: intel server SRMK2S with AMIBIOS and dual 1GHz PIII/256k 
> cache, 1GB memory, adaptec 7899 SCSI
> 
> DOES NOT BOOT

> I have attached the unpatched dsdt. To get rid of acpi error 
> messages, I 
> removed offending "Name()" lines. Please let me know if this is the 
> appropriate fix. As I said, it doesn't boot with the original 
> dsdt either.

I have an SCB2 system, whose ASL looks pretty similar to yours -- even some
of the same ASL problems. It boots for me with an SMP but not UP kernel.

Which are you trying?

If UP, can you please try this ASL change?

Search for this:

    Method(GETI, 1) {
        If(And(Arg0, 0xf, )) {
            Return(Zero)
        }
        Else {
            Return(\MLIB.CNV2(And(Arg0, 0xf, )))
        }
    }

And swap the contents of the if/else.

The Name() lines emit a warning but are harmless.

If you're having troubles in SMP mode, then I guess that is not shared
between our two platforms...

Thanks -- Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
