From: Karl Vogel <karl.vogel-/1BeJOKqmzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Acer Aspire 1511LMi - battery unreadable
Date: Sun, 13 Jun 2004 22:38:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406132238.03137.karl.vogel@seagha.com>
References: <200406132216.25172.karl.vogel@seagha.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200406132216.25172.karl.vogel-/1BeJOKqmzrQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Did some more research...

On Sunday 13 June 2004 22:16, Karl Vogel wrote:
> The Z005 is never used, but it is present in a definition:
>
>             Name (PBST, Package (0x04)
>             {
>                 0x00,
>                 Z005,
>                 Z005,
>                 0x2710
>             })
>
>
> I replaced those with 0x000 (not sure what the default value should be, 0
> sounds logical).
>
> The _PPC error is something I don't know how to resolve. Code looks like:
>
> -- usage code:
>                             If (LLess (\_PR.CPU0._PPC, Local1))
>                             {
>                                 Store (Local1, \_PR.CPU0._PPC)
>                                 Notify (\_PR.CPU0, 0x80)
>                                 Sleep (0x01F4)
>                             }
> ---

Just tried throwing out those _PPC lines and just changing the Z005->0x00 
since those are in the _BST. That seems to make the battery readout work!!

However, I'd like to keep those _PPC lines, since those are in the CPUT part, 
which is the cpu thermal control, I think?!?!


Relevant asl lines:

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
    }

[...]
                    Name (CPUT, 0x00)
                    Method (_Q80, 0, NotSerialized)
                    {
                        If (\_SB.ECOK)
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Store (\_SB.PCI0.LPC0.EC0.CTMP, Local0)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                        }
                        Else
                        {
                            Store (0x28, Local0)
                        }

                        Subtract (Local0, \_SB.TOFF, Local0)
                        If (LNot (LLess (Local0, 0x61)))
                        {
                            Notify (\_TZ.THRM, 0x80)
                        }

                        If (LAnd (LNot (LLess (Local0, 0x5C)), LEqual (CPUT, 
0x00)))
                        {
                            Store (0x01, CPUT)
                            Store (PNUM, Local1)
                            If (LLess (\_PR.CPU0._PPC, Local1))
                            {
                                Store (Local1, \_PR.CPU0._PPC)
                                Notify (\_PR.CPU0, 0x80)
                                Sleep (0x01F4)
                            }
                        }
                        Else
                        {
                            If (LAnd (LNot (LGreater (Local0, 0x57)), LNot 
(LEqual (CPUT, 0x00))))
                            {
                                Store (0x00, CPUT)
                                Store (0x00, Local1)
                                If (LEqual (Local1, 0x00))
                                {
                                    If (LNot (LEqual (\_PR.CPU0._PPC, 0x00)))
                                    {
                                        Store (0x00, \_PR.CPU0._PPC)
                                        Notify (\_PR.CPU0, 0x80)
                                        Sleep (0x01F4)
                                    }
                                }
                            }
                        }
                    }


Any tips?


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
