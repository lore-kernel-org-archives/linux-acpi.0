From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v3 11/12] ACPI: video: convert to acpi_get_pci_dev
Date: Fri, 26 Jun 2009 12:56:35 +0200
Message-ID: <81b0412b0906260356p12fd7807y40223175bf785cc0@mail.gmail.com>
References: <20090610194714.28982.51363.stgit@bob.kio>
	 <20090610195600.28982.3404.stgit@bob.kio>
	 <81b0412b0906251538j2614bf91ya2edbaf120796dfc@mail.gmail.com>
	 <20090625230535.GE1723@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:54291 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbZFZK4g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 06:56:36 -0400
In-Reply-To: <20090625230535.GE1723@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, twmoure@szypr.net, alessandro.suardi@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, linux-pci@vger.kernel.org

2009/6/26 Alex Chiang <achiang@hp.com>:
> Thanks for the bug report and sorry for the troubles.
>
> I've already got a debug patch here:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://thread.gmane.org/gmane.linux.kernel=
/857228/focus=3D857468
>
> Perhaps you can try it too?

Will do soon.

> Len, in the mean time, can you please apply this as an emergency,
> "let's not crash anyone else's machine" while I try and figure
> out why the ACPI video driver breaks my assumptions?

This patch helped, does not panic anymore.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
