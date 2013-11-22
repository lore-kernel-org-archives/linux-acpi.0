From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 3/7] net: rfkill: gpio: remove gpio conversion support
Date: Fri, 22 Nov 2013 11:40:32 -0700
Message-ID: <528FA520.7080501@wwwdotorg.org>
References: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com> <1385122474-14926-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1385122474-14926-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/22/2013 05:14 AM, Mika Westerberg wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> All platforms using this driver are now converted to the new
> descriptor-based GPIO interface.

Don't you want to remove the fields from the pdata structure too, since
it's pointless to set them anymore IIUC?
