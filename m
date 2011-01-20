From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [linux-pm] Resume from Memory very slow on 2.6.37+
Date: Thu, 20 Jan 2011 09:21:30 +0800
Message-ID: <AANLkTinvz=syQgiWkQLgu2ssutBNccKuyxdPcGj97npU@mail.gmail.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101190238.18529.rjw@sisk.pl>
	<AANLkTimf3B=z1DCA2q+yi-ccyAJwmjkB_g8EP=ZTehmn@mail.gmail.com>
	<201101192219.07569.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42042 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab1ATBVb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jan 2011 20:21:31 -0500
Received: by iyj18 with SMTP id 18so47572iyj.19
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jan 2011 17:21:30 -0800 (PST)
In-Reply-To: <201101192219.07569.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Jan 20, 2011 at 5:19 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> OK, I'd like you to test the two patches I'll send in replies to this
> message.
> [1/2] - It will go back to using ioremap_cache() for NVS pages alloca=
tions.

Applied. This one makes resume effective.

> [2/2] - This one will move suspend_nvs_free() before device drivers' =
resume
> =A0 =A0 =A0 =A0callbacks (should avoid conflicts with the drivers' ma=
ppings).

Applied. This one makes no difference. Without applying [1/2], this
one makes resume hangs, so definitely needs to go along with [1/2].

Applied both and I've tried a few cycles and resume still working ok.

Thanks,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
