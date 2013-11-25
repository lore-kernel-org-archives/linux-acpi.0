From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 3/7] net: rfkill: gpio: remove gpio conversion support
Date: Mon, 25 Nov 2013 10:35:59 +0200
Message-ID: <20131125083559.GA21001@xps8300>
References: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com>
 <1385122474-14926-4-git-send-email-mika.westerberg@linux.intel.com>
 <528FA520.7080501@wwwdotorg.org>
 <20131122205640.GA21895@xps8300>
 <528FC60A.80308@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528FC60A.80308@wwwdotorg.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2013 at 02:00:58PM -0700, Stephen Warren wrote:
> On 11/22/2013 01:56 PM, Heikki Krogerus wrote:
> > I have prepared a separate patch where I remove those and some other
> > unused fields from the pdata structure (attachment). Would it be OK to
> > add that to this patch set? Or should this patch simply be updated?
> 
> I would suggest killing off the two GPIO fields in this patch, since
> it's logically part of this change. I think the balance of the patch is
> unrelated to gpiod conversion, so should probably be sent separately,
> although watch out for dependencies.

Yes, we'll do it like that.

Thanks,

-- 
heikki
