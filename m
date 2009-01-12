From: "Corentin Chary" <corentin.chary@gmail.com>
Subject: Re: Fwd: [PATCH 01/02] Initial work to let ACPI buttons work over INPUT layer
Date: Mon, 12 Jan 2009 13:00:28 +0100
Message-ID: <71cd59b00901120400t1545e85avcfaa5b23a3c3ee79@mail.gmail.com>
References: <200811291834.46109.dnascimento@gmail.com>
	 <4ff2fa00812190834s8ef5629ofa1f17a74aa6bfef@mail.gmail.com>
	 <1231328320.402.5.camel@zimtstern>
	 <71cd59b00901120359h4c0ff723v4f49bdd180fcc9e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:38839 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbZALMAc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jan 2009 07:00:32 -0500
Received: by bwz14 with SMTP id 14so31972863bwz.13
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2009 04:00:30 -0800 (PST)
In-Reply-To: <71cd59b00901120359h4c0ff723v4f49bdd180fcc9e8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timo Hoenig <thoenig@nouse.net>
Cc: lenb@kernel.org, Nicolas Trangez <ikke@nicolast.be>, sziwan@users.sourceforge.net, linux-acpi@vger.kernel.org, Daniel Nascimento <dnascimento@gmail.com>

> I don't think this patch is ok, things should be done in cleaner way,
> like it's eeepc-laptop.
Sorry : like it's done in eeepc-laptop.

Take a look at struct eeepc_keymap and eeepc_hotk_notitfy().


-- 
Corentin Chary
http://xf.iksaif.net
