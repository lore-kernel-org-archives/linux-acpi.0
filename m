From: "Dennis Jansen" <Dennis.Jansen@web.de>
Subject: Please queue for 2.6.27 Re: [PATCH] ACPI: Fix typo in "Disable MWAIT via DMI on broken Compal board"
Date: Thu, 21 Aug 2008 08:28:05 +0200
Message-ID: <e678b6ed0808202328j3cf53c6jafa103de142a956c@mail.gmail.com>
Reply-To: d.g.jansen@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:18715 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbYHUG2G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 02:28:06 -0400
Received: by wr-out-0506.google.com with SMTP id 69so711069wri.5
        for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2008 23:28:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 8/20/08, Dennis Jansen <Dennis.Jansen@web.de> wrote:
> This fixes a typo in commit 2a2a64714d9c40f7705c4de1e79a5b855c7211a9
>  "Disable MWAIT via DMI on broken Compal board".
>
>  It allows the nomwait dmi check to actually detect the Acer 5220.

I should add that it should go into 2.6.27, as the commit it fixes is
also just in.
