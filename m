From: "Vladimir 'phcoder' Serbinenko" <phcoder@gmail.com>
Subject: Re: Bad _BQC behaviour on Packard Bell Easynot BG-45
Date: Fri, 31 Jul 2009 15:16:53 +0200
Message-ID: <d7ead6de0907310616p3c3cc4a4qd64bb1fb26394686@mail.gmail.com>
References: <d7ead6de0906090819h177b7495xaa98dd062abf1f62@mail.gmail.com>
	 <1244600682.9076.71.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:42529 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZGaNQy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 09:16:54 -0400
Received: by ewy10 with SMTP id 10so1491483ewy.37
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2009 06:16:53 -0700 (PDT)
In-Reply-To: <1244600682.9076.71.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Jun 10, 2009 at 4:24 AM, Zhang Rui<rui.zhang@intel.com> wrote:
> On Tue, 2009-06-09 at 23:19 +0800, Vladimir 'phcoder' Serbinenko wrot=
e:
>> Hello. On the following model
>> =A0 =A0 =A0 Manufacturer: Packard Bell BV
>> =A0 =A0 =A0 Product Name: EasyNote_BG45-U-001CH
>> BQC returns a value between 0 and 15 but the brightness levels are
>> between 0 and 8. I could make a table of correspondance however I fi=
nd
>> it too inflexible. So I propose the following patch which disables B=
QC
>> if it behaves badly
>>
> the patch seems good.
> could you please send the acpidump of your laptop so that we can see =
if
> there is any chance that we can enable the brightness control on this
> laptop?
>
Is there any reason why this patch haven't been comitted?
> thanks,
> rui
>
>



--=20
Regards
Vladimir 'phcoder' Serbinenko

Personal git repository: http://repo.or.cz/w/grub2/phcoder.git
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
