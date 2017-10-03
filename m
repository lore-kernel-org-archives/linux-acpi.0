From: =?UTF-8?B?SsOpcsOpbXk=?= Lefaure <jeremy.lefaure@lse.epita.fr>
Subject: Re: [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Mon, 2 Oct 2017 21:16:22 -0400
Message-ID: <20171002211622.30d324ca@blatinox-laptop.localdomain>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
        <20171001193101.8898-16-jeremy.lefaure@lse.epita.fr>
        <1668017.YFhvic4TWu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1668017.YFhvic4TWu@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 02 Oct 2017 14:27:52 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> ACPICA is soewhat special code, though and I'm not taking or ACKing patches
> for it directly as a rule.
> 
> For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
Why is it special code that can't use ARRAY_SIZE ? Is it because this
macro is defined in linux/kernel.h ?

Thank you,
Jérémy
