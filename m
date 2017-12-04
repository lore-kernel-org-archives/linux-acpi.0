From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH] ACPI / LPSS: Add device link for CHT SD card dependency
 on I2C
Date: Mon, 4 Dec 2017 13:56:41 +0000
Message-ID: <CAL9uMOGhf-DEmsV9ZGETof51EuU5YLs41umPdu+p2eh3zv2=cw@mail.gmail.com>
References: <1512390731-11171-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512390731-11171-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 4, 2017 at 12:32 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Some Cherry Trail boards have a dependency between the SDHCI host
> controller used for SD cards and an external PMIC accessed via I2C. Add a
> device link between the SDHCI host controller (consumer) and the I2C
> adapter (supplier).
>
> This patch depends on a fix to devices links, namely commit 0ff26c662d5f
> ("driver core: Fix device link deferred probe"). And also either,
> commit 126dbc6b49c8 ("PM: i2c-designware-platdrv: Clean up PM handling in
> probe"), or patch "PM / runtime: Fix handling of suppliers with disabled
> runtime PM".
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Hey Adrian,
thank you for working on this.

I tried this patch on top of linus HEAD (0ff26c662d5f and 126dbc6b49c8
are already applied) but I'm still experiencing some difficulties with
some SD cards on the cherry-trail laptop I'm working with. You can
find the DSDT in [0].

With an ultra high speed SDR104 SDHC card I get:

  mmc2: Tuning timeout, falling back to fixed sampling clock
  mmc2: new ultra high speed SDR104 SDHC card at address 59b4
  mmcblk2: mmc2:59b4 USD00 15.0 GiB
  mmc2: Timeout waiting for hardware interrupt.
  mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
  mmc2: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
  mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
  mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
  mmc2: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000017
  mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
  mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
  mmc2: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
  mmc2: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
  mmc2: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
  mmc2: sdhci: Caps:      0x0568c8b2 | Caps_1:   0x00000807
  mmc2: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
  mmc2: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x0077dd7f
  mmc2: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00000000
  mmc2: sdhci: Host ctl2: 0x0000800b
  mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x33773200
  mmc2: sdhci: ============================================
  mmcblk2: error -110 sending status command, retrying
  mmcblk2: error -110 sending status command, retrying
  mmcblk2: error -110 sending status command, aborting
  mmc2: Tuning timeout, falling back to fixed sampling clock

For an high speed SDHC card I simply get:

  mmc2: error -110 whilst initialising SD card

Some other cards just work fine, i.e. ultra high speed DDR50.

At this point I'm not sure if the problem I'm seeing is actually
related to the issue you are fixing with this commit (and if now,
sorry to have hijacked this thread).
Any idea on that?

Thank you,

[0] https://gist.github.com/carlocaione/82bff95ababb67dd33f52a86e94ce3ff

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
