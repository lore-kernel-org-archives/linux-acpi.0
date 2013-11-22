From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 3/7] net: rfkill: gpio: remove gpio conversion support
Date: Fri, 22 Nov 2013 14:00:58 -0700
Message-ID: <528FC60A.80308@wwwdotorg.org>
References: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com> <1385122474-14926-4-git-send-email-mika.westerberg@linux.intel.com> <528FA520.7080501@wwwdotorg.org> <20131122205640.GA21895@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20131122205640.GA21895@xps8300>
Sender: linux-gpio-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/22/2013 01:56 PM, Heikki Krogerus wrote:
> On Fri, Nov 22, 2013 at 11:40:32AM -0700, Stephen Warren wrote:
>> On 11/22/2013 05:14 AM, Mika Westerberg wrote:
>>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>
>>> All platforms using this driver are now converted to the new
>>> descriptor-based GPIO interface.
>>
>> Don't you want to remove the fields from the pdata structure too, since
>> it's pointless to set them anymore IIUC?
> 
> Agreed. We should have removed them in this patch.
> 
> I have prepared a separate patch where I remove those and some other
> unused fields from the pdata structure (attachment). Would it be OK to
> add that to this patch set? Or should this patch simply be updated?

I would suggest killing off the two GPIO fields in this patch, since
it's logically part of this change. I think the balance of the patch is
unrelated to gpiod conversion, so should probably be sent separately,
although watch out for dependencies.

