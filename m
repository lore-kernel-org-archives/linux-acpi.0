From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: AE_ERROR, ACPI thermal trip point state changed
Date: Mon, 08 Dec 2008 07:04:11 +0100
Message-ID: <493CB8DB.8070105@freemail.hu>
References: <47CF96E2.9020302@freemail.hu> <1204757373.10256.179.camel@acpi-hp-zz.sh.intel.com> <823A93EED437D048963A3697DB0E35DE0129BB78@pdsmsx414.ccr.corp.intel.com> <47D0E694.5050102@freemail.hu> <1204874686.10256.185.camel@acpi-hp-zz.sh.intel.com> <47D24341.5070908@freemail.hu> <1205113940.10256.191.camel@acpi-hp-zz.sh.intel.com> <48ABDF1E.3010101@freemail.hu> <8763pwypf5.fsf@basil.nowhere.org> <49249121.6050304@freemail.hu> <20081119232224.GR6703@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail02a.mail.t-online.hu ([84.2.40.7]:64869 "EHLO
	mail02a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbYLHGEP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Dec 2008 01:04:15 -0500
In-Reply-To: <20081119232224.GR6703@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, lenb@kernel.org

Andi Kleen wrote:
> On Wed, Nov 19, 2008 at 11:20:17PM +0100, N=E9meth M=E1rton wrote:
>> Hi,
>>
>> Andi Kleen wrote:
>>> N=E9meth M=E1rton <nm127@freemail.hu> writes:
>>>> As of 2.6.27-rc3 the patch is still not included in the mainstream=
=2E I
>>>> hope that this patch was not forgotten completely.
>>> It's already in Linus' tree, will be in rc4.
>> I compiled and tried 2.6.28-rc5. In the dmesg I get the following me=
ssage:
>>
>> [   63.589603] ACPI Exception (thermal-0538): AE_ERROR, ACPI thermal=
 trip point state changed
>> [   63.589669] Please send acpidump to linux-acpi@vger.kernel.org
>> [   63.589805]  [20080926]
>>
>> The original patch still applies for 2.6.28-rc5 (with some offsets).=
 This patch
>> is not included in 2.6.28-rc5, yet. The "AE_ERROR..." message does n=
ot appear
>> any more if I apply the patch. I attached this original patch for ea=
sier reference.
>=20
> Hmm sorry I must have confused it with some other patch back then.
> Anyways Len Brown is handling ACPI again now, so he'll have to sort
> it out. cc'ed (the original patch is on linux-acpi)

This is just a status report about 2.6.28-rc7, nothing more. The AE_ERR=
OR
message is still in the dmesg. The patch still solves the problem.

Regards,

	M=E1rton N=E9meth
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
