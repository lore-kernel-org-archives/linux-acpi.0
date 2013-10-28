From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] ACPI: remove unused ACPI_PROCFS Kconfig param
Date: Mon, 28 Oct 2013 09:27:35 +0100
Message-ID: <1382948855.32195.9.camel@x220.thuisdomein>
References: <1382857012-2971-1-git-send-email-michael.opdenacker@free-electrons.com>
	 <CAOLK0pxe0tsgo1+U8WT4-9cxTxS9MKaiGhLd2S-T-T7imPyd7A@mail.gmail.com>
	 <526E0293.4080702@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <526E0293.4080702@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: Lan Tianyu <lantianyu1986@gmail.com>, Len Brown <lenb@kernel.org>, rjw@rjwysocki.net, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2013-10-28 at 07:22 +0100, Michael Opdenacker wrote:
> [...] CONFIG_ACPI_PROCFS is no longer used anywhere, neither in
> Makefiles nor in the source code. ACPI_PROCFS isn't event used in
> Kconfig files as an intermediate dependency.
> 
> What I deduce from that is that even if you set CONFIG_ACPI_PROCFS=y in
> the kernel configuration, this will have no impact at all.

About half a year ago I noticed that this Kconfig symbol is unused since
v2.6.38 [0]. As, apparently, nothing has changed it is currently unused
for over two and a half years.

I still don't really understand the purpose of this symbol. But whatever
it is, it might as well be dropped. If it's ever needed again it could
be re-added. Or, perhaps, an entirely different approach could be used
to accomplish what that symbol is supposed to do.


Paul Bolle

[0] http://marc.info/?l=linux-acpi&m=136398635322975
