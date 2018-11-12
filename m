From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Date: Mon, 12 Nov 2018 17:05:46 +0200
Message-ID: <20181112150546.GC1677@kuha.fi.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
 <20181108192509.GW10650@smile.fi.intel.com>
 <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
 <20181109133442.GA28183@kuha.fi.intel.com>
 <CABGGiswFe92TLtU6YH3UsQJBbACbHu2w0rmc7FvwURqi_PU+7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABGGiswFe92TLtU6YH3UsQJBbACbHu2w0rmc7FvwURqi_PU+7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: andriy.shevchenko@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, mika.westerberg@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, Nov 09, 2018 at 10:14:49AM -0600, Rob Herring wrote:
> > I would prefer that we had something like of_node_name_get() function
> > that of_fwnode_get_name() could simply call. I don't know how you want
> > that implemented, but I'm expecting you will implement something like
> > that in any case once you start removing that ->name member. I figured
> > that at that point we can update of_fwnode_get_name() as well.
> 
> I don't plan to implement anything like that. Here's what I'm planning:
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/testing
> 
> Which is eliminating the need to access .name by: using %pOFn (mostly
> in 4.20), using of_node_name_eq() wrapper, or using full_name instead.
> The last case generally is cases where the name is not important such
> as request_irq() or irq_chip.name.

OK. Thanks for the explanation.


thanks,

-- 
heikki
