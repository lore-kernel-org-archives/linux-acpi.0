From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: kernel panic
Date: Tue, 25 Oct 2011 14:55:59 -0600
Message-ID: <CAErSpo4EtfhnhWGpahk-NfMUVEizZSk3igZ+Vy7x=+hY5b0bcw@mail.gmail.com>
References: <4EA549C3.4080206@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EA549C3.4080206@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick bray <nick.bray1@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

[+linux-acpi]

On Mon, Oct 24, 2011 at 5:19 AM, nick bray <nick.bray1@ntlworld.com> wr=
ote:
> Hi,
> =A0after upgrading to linux kernel 3.xx I get kernel panic on boot un=
less I
> use ACPI=3Doff in the boot parameters this happens with both Ubuntu 1=
1.10 and
> Fedora 16. The mainboard is an Intel S875WP1-E running a Pentuim 4 3g=
hz with
> 3gig RAM in single-channel mode. I have performed a Bios upgrade just=
 in
> case tha ACPI tables were corrupt but it makes no difference. Current=
ly
> running 2.6.38-11-generic #50-Ubuntu SMP (Linux Mint) with no issues.=
 I can
> provide a screenshot if you wish but it's looking like it's ACPI rela=
ted as
> above.

Yes, please provide a screenshot.  A serial console log with "acpi=3Dof=
f
ignore_loglevel" would be even better.

Bjorn
