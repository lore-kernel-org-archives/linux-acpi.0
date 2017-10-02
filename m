From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Mon, 02 Oct 2017 14:27:52 +0200
Message-ID: <1668017.YFhvic4TWu@aspire.rjw.lan>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr> <20171001193101.8898-16-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42797 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750929AbdJBMhL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Oct 2017 08:37:11 -0400
In-Reply-To: <20171001193101.8898-16-jeremy.lefaure@lse.epita.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?J=E9r=E9my?= Lefaure <jeremy.lefaure@lse.epita.fr>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

On Sunday, October 1, 2017 9:30:53 PM CEST Jérémy Lefaure wrote:
> Using the ARRAY_SIZE macro improves the readability of the code. It is
> useless to re-invent the ARRAY_SIZE macro so let's use it.
> 
> It is useless to re-invent the ARRAY_SIZE macro so let's use it.

ACPICA is soewhat special code, though and I'm not taking or ACKing patches
for it directly as a rule.

For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.

Thanks,
Rafael

