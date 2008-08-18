From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [git pull?] clocksource: ACPI pmtmr bugfixes [Was: Re: ACPI
	PM-Timer on K6-3 SiS5591: Houston...]
Date: Mon, 18 Aug 2008 21:03:25 +0200
Message-ID: <20080818190325.GA12581@comet.dominikbrodowski.net>
References: <20080810101730.GA10024@rhlx01.hs-esslingen.de> <20080810162920.GA9860@comet.dominikbrodowski.net> <20080810190759.GA1879@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932825AbYHRTJx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080810190759.GA1879@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
Cc: john stultz <johnstul@us.ibm.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>, Andreas Mohr <andi@lisas.de>
List-Id: linux-acpi@vger.kernel.org

Hi,

anyone willing to take these two patches? Possibly 2.6.27 material; hasn't
been in -next or -mm.

Best,
	Dominik


The following changes since commit 796aadeb1b2db9b5d463946766c5bbfd7717158c:
  Linus Torvalds (1):
        Merge branch 'fixes' of git://git.kernel.org/.../davej/cpufreq

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git clocksource

Dominik Brodowski (2):
      acpi_pm.c: use proper read function also in errata mode.
      acpi_pm.c: check for monotonicity

 drivers/clocksource/acpi_pm.c |   50 +++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 21 deletions(-)
