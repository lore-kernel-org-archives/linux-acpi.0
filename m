From: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Subject: Re: iasl
Date: Mon, 12 May 2003 14:29:58 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EBFAFE6.2020700@ottaky.com>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3C62@orsmsx405.jf.intel.com> <20030512101655.GB19351@poup.poupinou.org> <3EBF9263.6040405@ottaky.com> <20030512132149.GA19475@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030512132149.GA19475-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ducrot Bruno wrote:

> Therefore, looking a little bit more, I think (not sure at 100% though)
> that it is an ALi subsystem.

Yes it is .. details of the machine are at

http://www.ottaky.com/vaiou1.php

>                 OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
>                 Field (PIUC, ByteAcc, Lock, Preserve)
>                 {
>                     PIRU,   4
>                 }
> 
> That make more sense for me.
> It should be related to USB routing control for
> this ali southbridge chipset, which
> have to be accessed as byte.

I made the change and ..

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 381 Optimizations

.. it looks good.

Thanks!

sjb



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
