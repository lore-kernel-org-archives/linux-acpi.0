From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (HP pavilion dv5000)
Date: Sun, 20 Jan 2008 14:54:12 -0500
Message-ID: <200801201454.12257.lenb@kernel.org>
References: <4679A480.1020507@cosy.sbg.ac.at> <200801181827.47446.lenb@kernel.org> <4791DF76.9060201@cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33802 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755114AbYATTyf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:54:35 -0500
In-Reply-To: <4791DF76.9060201@cosy.sbg.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Tamme <mtamme@cosy.sbg.ac.at>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 06:31, Martin Tamme wrote:
> I didn't notice any difference between "acpi_osi=Linux" and
> "acpi_osi=!Linux".
> 
> Len Brown wrote:
> > On Wednesday 20 June 2007 18:04, Martin Tamme wrote:
> >>         Manufacturer: Hewlett-Packard
> >>         Product Name: HP Pavilion dv5000 (RG959EA#ABD)
> >>         Version: F.23
> >>         Serial Number: CND63436SJ
> >>         UUID: CAB23257-2998-11DB-BA5A-0016D43EC990
> >>         Wake-up Type: Power Switch
> >>         SKU Number: RG959EA#ABD
> >>         Family: 103C_5335KV
> >>
> >> Handle 0x0002, DMI type 2, 8 bytes
> >> Base Board Information
> >>         Manufacturer: Hewlett-Packard
> >>         Product Name: 30A7
> > 

thanks for the acpidump -- it shows that OSI(Linux) is a NOP
on this box, for LINX is never referenced.

-Len

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                }
....

    OperationRegion (GNVS, SystemMemory, 0x7FE93E4C, 0x0100)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,
        SMIF,   8,
        PRM0,   8,
        PRM1,   8,
        SCIF,   8,
        PRM2,   8,
        PRM3,   8,
        LCKF,   8,
        PRM4,   8,
        PRM5,   8,
        P80D,   32,
        LIDS,   8,
        PWRS,   8,
        DBGS,   8,
        LINX,   8,
                Offset (0x14),
