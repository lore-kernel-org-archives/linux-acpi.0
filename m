From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] ACPI: eliminate unused variable warning for
	 !ACPI_SLEEP
Date: Mon, 13 Dec 2010 07:59:21 +0000
Message-ID: <4D05E06902000078000277AB@vpn.id2.novell.com>
References: <4CFE583902000078000266E9@vpn.id2.novell.com>
 <alpine.LFD.2.00.1012110058320.28169@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1012110058320.28169@x980>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

>>> On 11.12.10 at 07:00, Len Brown <lenb@kernel.org> wrote:
> applied,
> though i'd rather see a pach that makes unreasonable/unlikely
> config combinations such as ACPI && !ACPI_SLEEP impossible.

What's so wrong about !ACPI_SLEEP? Not everyone wants/needs
suspend/hibernate capabilities...

Jan

