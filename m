From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: iasl
Date: Mon, 12 May 2003 11:48:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030512094816.GA19351@poup.poupinou.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3C62@orsmsx405.jf.intel.com> <3EBC2D94.7040801@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3EBC2D94.7040801-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 09, 2003 at 10:37:08PM +0000, sjb wrote:
> Moore, Robert wrote:
> 
> >In this case, we know that PCI_Config space is always accessed by 32-bit
> >reads/writes, so change the Op region definition to length 4.
> 
> OK .. so I change the 0x01 here
> 
> >>>>               OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
> 
> to a 0x04 and re-compile and .. *drum roll* ..
> 
> Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 380 Optimizations
> 
> Excellent!
> 


The _only way_ to fix *correctly* this error is to know the
definition of all Field like 

Field (PIUC, ...) 
{
...
}

But you didn't give us this info.

For example, if it is
OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
Field (REGS, DWordAcc, NoLock, Preserve)
({
	FOO, 8
})

Then a better fix is to make this:

Field (REGS, DWordAcc, NoLock, Preserve)
changed as:
Field (REGS, ByteAcc, NoLock, Preserve)

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
