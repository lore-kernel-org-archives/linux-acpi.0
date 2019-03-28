From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
	function
Date: Fri, 29 Mar 2019 00:33:33 +0100
Message-ID: <CAJZ5v0jP8bXiQzFLSFPZ7xcHfxtMv93C-ybaZjqkuj+vjLH_5g@mail.gmail.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <0daff2ba-3322-be9c-9afb-0d74b9d0827e@linux.intel.com>
 <20190328214019.GP9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190328214019.GP9224@smile.fi.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 28, 2019 at 10:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 28, 2019 at 02:31:28PM -0400, Pierre-Louis Bossart wrote:
> > On 3/28/19 1:17 PM, Andy Shevchenko wrote:
> > > The acpi_dev_get_first_match_name() is missing put_device() call
> > > and thus keeping reference counting unbalanced.
> > >
> > > In order to fix the issue introduce a new helper to convert existing users
> > > one-by-one to a better API.
> > >
> > > Since v3:
> > > - convert all existing users and drop old API (Mika)
> > > - add Hans' tag
> > >
> > > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Patches 4..9 for the Intel machine drivers:
> >
> > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> Thank you!
>
> > Is this going to be merged through the ACPI or ASoC tree? The changes will
> > conflict with cleanups I started to use the 'modern' dailinks (codec_name ->
> > codecs[0].name), so some level of coordination is needed.
>
> I suppose via ACPI.

I can expose a non-volatile branch with this material, would that work?
