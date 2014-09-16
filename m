From: Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH for AMD Seattle 0/4] Drivers for AMD-Seatlle to boot
 from ACPI
Date: Tue, 16 Sep 2014 18:56:52 -0400
Message-ID: <5418C034.8020305@redhat.com>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com> <5417BC57.4030504@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbaIPW5r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Sep 2014 18:57:47 -0400
In-Reply-To: <5417BC57.4030504@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-kernel@vger.kernel.org, astone@redhat.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, marc.zyngier@arm.com, mark.rutland@arm.com, Sudeep.Holla@arm.com, olof@lixom.net, grant.likely@linaro.org, graeme.gregory@linaro.org, arnd@arndb.de, jason@lakedaemon.net, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 09/16/2014 12:28 AM, Suravee Suthikulpanit wrote:
> Note: Correcting the typo for linux-acpi mailing list in this reply.
>=20
> Also, I would like to add the link to the "AMD Opteron=99 A1100 Serie=
s=20
> Processor ACPI Porting Guide", which describes the current ACPI table=
=20
> for AMD Seattle platform here:
>=20
> http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattl=
e_ACPI_Guide.pdf

Thanks again for posting the patch series, and this document, which is
very useful. We have test systems running these patches right now, and
they work quite well. If anyone at Linaro Connect this week would like
to see hardware and get their own kernel built running these bits, let
myself, Suravee, or Al know and we'll help you make that happen.

Jon.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
