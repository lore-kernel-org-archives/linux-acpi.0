From: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Subject: Re: More initial black screen system for removal from DMI table
Date: Thu, 14 Nov 2013 09:50:33 -0200
Message-ID: <1384429833.4103.23.camel@oberon.sagui.org>
References: <1367828623-22998-1-git-send-email-alex.hung@canonical.com>
		<52818C87.8080606@intel.com>
	 <CAJ=jqubGRRYuKF2yFsGYniKu5=PotL6OR3KYjhhz-Zsx5wT+iA@mail.gmail.com>
	 <5282DEEE.1040804@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from horatio.sagui.org ([173.230.138.212]:40655 "EHLO
	horatio.sagui.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab3KNL6U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2013 06:58:20 -0500
In-Reply-To: <5282DEEE.1040804@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Alex Hung <alex.hung@canonical.com>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Em Qua, 2013-11-13 =C3=A0s 10:07 +0800, Aaron Lu escreveu:
> Hi Gustavo,
> Can you please test this? I've prepared a branch for you:
> https://github.com/aaronlu/linux acpi_video_dmi
> It is based on Rafael's linux-next branch, with only one patch
> on top: remove all the above systems from the DMI table.

Aaron, thanks for setting the branch up. However, I will only be able t=
o
test it over the weekend.=20

=46or completeness my instance of the bug was (wrongly) tracked here:
https://bugs.freedesktop.org/show_bug.cgi?id=3D43577

Abra=C3=A7os,
Gustavo

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
