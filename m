From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: iasl
Date: Mon, 12 May 2003 15:21:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030512132149.GA19475@poup.poupinou.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3C62@orsmsx405.jf.intel.com> <20030512101655.GB19351@poup.poupinou.org> <3EBF9263.6040405@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3EBF9263.6040405-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, May 12, 2003 at 12:24:03PM +0000, sjb wrote:
> Ducrot Bruno wrote:
> 
> >Unless sjb give us more info, we can not tell anything at this
> >stage.
> 
> OK .. the dsdt is here
> 
> http://www.ottaky.com/misc/dsdt.dsl.gz
> 

I can't believe it.. Really.

This is done like this:

                OperationRegion (PIUC, PCI_Config, 0x74, 0x04)
                Field (PIUC, DWordAcc, Lock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    PIRU,   4
                }


I assume the original one was:

                OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
                Field (PIUC, DWordAcc, Lock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    PIRU,   4
                }

Therefore, looking a little bit more, I think (not sure at 100% though)
that it is an ALi subsystem.

sjb, could you please try:

                OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
                Field (PIUC, ByteAcc, Lock, Preserve)
                {
                    PIRU,   4
                }

That make more sense for me.
It should be related to USB routing control for
this ali southbridge chipset, which
have to be accessed as byte.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
