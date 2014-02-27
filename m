From: Kieran Clancy <clancy.kieran@gmail.com>
Subject: Re: [PATCH] ACPI / EC: Clear stale EC events on Samsung systems
Date: Thu, 27 Feb 2014 11:29:53 +1030
Message-ID: <CAGf84QK=YDN6MHTzEEc-1rbWHyGkBSbSdobaUwXV18d++EO+eg@mail.gmail.com>
References: <1393429360-4344-1-git-send-email-clancy.kieran@gmail.com>
 <1670100.tBHUbYFGo0@vostro.rjw.lan> <CAGf84QK75jsXdnehwDNr8g+dCvdQKQ7+bgXmsbF_YFMKKYoGGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:58516 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbaB0BAY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Feb 2014 20:00:24 -0500
In-Reply-To: <CAGf84QK75jsXdnehwDNr8g+dCvdQKQ7+bgXmsbF_YFMKKYoGGw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>, Juan Manuel Cabo <juanmanuel.cabo@gmail.com>, Dennis Jansen <dennis.jansen@web.de>

On Thu, Feb 27, 2014 at 11:15 AM, Kieran Clancy <clancy.kieran@gmail.com> wrote:
>
> I am the primary author, but I based the loop which calls
> acpi_ec_query_unlocked() on a patch by Lan Tianyu. Juan provided the
> initial idea (userspace workaround), and Dennis and Lan Tianyu
> reviewed and suggested some changes to the code.

Oh, and I should add that Juan and Dennis both helped to test the
patch extensively.

Kieran
