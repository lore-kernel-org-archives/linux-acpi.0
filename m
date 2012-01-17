From: Kurt Garloff <kurt@garloff.de>
Subject: Re: [PATCH 1/3]: Store SRAT revision
Date: Tue, 17 Jan 2012 14:20:11 +0100
Message-ID: <2cf343f2-24d6-4912-b4fe-121956cdd612@email.android.com>
References: <20120115213005.GT12380@tpkurt2.garloff.de> <20120115213407.GU12380@tpkurt2.garloff.de> <4F153E53.6020108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cc-smtpout2.netcologne.de ([89.1.8.212]:46381 "EHLO
	cc-smtpout2.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab2AQNUX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 08:20:23 -0500
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
	by cc-smtpout2.netcologne.de (Postfix) with ESMTP id E77A012BE9
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 14:20:20 +0100 (CET)
Received: from nas.garloff.de (xdsl-78-34-172-221.netcologne.de [78.34.172.221])
	by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA id DF7A711DB4
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 14:20:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by nas.garloff.de (Postfix) with ESMTP id 4317D3D8B7EB
	for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 14:20:20 +0100 (CET)
Received: from [10.45.118.46] ([82.113.121.46]:4991)
	by QNAPSS439 with [XMail 1.26 ESMTP Server]
	id <S1C6F> for <linux-acpi@vger.kernel.org> from <kurt@garloff.de>;
	Tue, 17 Jan 2012 14:20:17 +0100
In-Reply-To: <4F153E53.6020108@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, x86@vger.kernel.org

Len,



Len Brown <lenb@kernel.org> schrieb:

> looks fine to me.
> as #2 (x86) and #3 (ia64) depend on #1, which is ACPI,
> I can send this via the ACPI tree.

Thanks for reviewing this!
I'll wait for the git commits then and resubmit to stable (forgot to ad=
d a Cc line in the signed-off section, as GKH thankfully pointed out).

Thx,
--=20
Kurt Garloff <kurt@garloff.de>  [K=C3=B6ln/Greven]
(Sent from Android phone with K-9 Mail.)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
