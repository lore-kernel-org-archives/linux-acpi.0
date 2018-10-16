From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Date: Tue, 16 Oct 2018 10:32:44 -0700
Message-ID: <20181016173244.GB230131@dtor-ws>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Heikki,

On Fri, Oct 12, 2018 at 02:39:29PM +0300, Heikki Krogerus wrote:
> Hi guys,
> 
> To continue the discussion started by Dmitry [1], this is my proposal
> that I mentioned in my last mail. In short, the idea is that instead
> of trying to extend the support for the currently used struct
> property_set, I'm proposing that we introduce a completely new,
> independent type of fwnode, and replace the struct property_set with
> it. I'm calling the type "software node" here.
> 
> The reason for a complete separation of the software nodes from the
> generic property handling code is the need to be able to create the
> nodes independently from the devices that they are bind to.

It would be great it you would provide an example of creating these
sowftware property sets separately from devices. How do you tie device
and its properties if they are not created together? For OF we have
compatibles and phandles for references, ACPI has HIDs and CIDs and
notion of references as well. What do we use here, especially when
software node is created in one subsystem (let's say
drivers/platform/x86), but device is created somewhere else?

Another issue that is not clear to me: looking at the USB connector it
seems you want to have references to fwnodes. How do you resolve them
when there are nodes of different class. I.e. how do you express
software fwnode referencing ACPI or DT node when you are supplementing
ACPI or DT description of a system with these custom/secondary nodes?
What about the other direction? I.e. can I have a DT system with USB
connector and augment USB set up with static nodes? Not only
basic/scalar properties, but links as well?

As I said, having and example of using this new code to achieve your
goal with regard to USB connector would be awesome and clear a lot of my
questions.

Thanks!

-- 
Dmitry
