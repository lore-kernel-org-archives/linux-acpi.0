From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: More initial black screen system for removal from DMI table
Date: Fri, 15 Nov 2013 08:42:38 +0800
Message-ID: <52856DFE.3000003@intel.com>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>		<52818C87.8080606@intel.com>	 <CAJ=jqubGRRYuKF2yFsGYniKu5=PotL6OR3KYjhhz-Zsx5wT+iA@mail.gmail.com>	 <5282DEEE.1040804@intel.com> <1384429833.4103.23.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21340 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab3KOAlu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Nov 2013 19:41:50 -0500
In-Reply-To: <1384429833.4103.23.camel@oberon.sagui.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Cc: Alex Hung <alex.hung@canonical.com>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On 11/14/2013 07:50 PM, Gustavo Maciel Dias Vieira wrote:
> Em Qua, 2013-11-13 =C3=A0s 10:07 +0800, Aaron Lu escreveu:
>> Hi Gustavo,
>> Can you please test this? I've prepared a branch for you:
>> https://github.com/aaronlu/linux acpi_video_dmi
>> It is based on Rafael's linux-next branch, with only one patch
>> on top: remove all the above systems from the DMI table.
>=20
> Aaron, thanks for setting the branch up. However, I will only be able=
 to
> test it over the weekend.=20

No problem :-)

>=20
> For completeness my instance of the bug was (wrongly) tracked here:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D43577

Thanks for the info. Unfortunately, there isn't acpidump either.
Please attach the dump there when you have time, thanks.

As root:
# acpidump > acpidump.txt

-Aaron
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
