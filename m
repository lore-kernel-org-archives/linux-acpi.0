From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 3/3] of/property: Add of_fwnode_name()
Date: Fri, 14 Dec 2018 11:46:02 -0600
Message-ID: <CAL_JsqLn3dbt-8Hjoja5AJip7FxLoWLAh0Cuk1eqE3Z8RiaO1A@mail.gmail.com>
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
 <20181211131451.52832-4-heikki.krogerus@linux.intel.com> <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 14, 2018 at 3:36 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 11, 2018 at 2:15 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > This implements get_name fwnode op for DT.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Rob, any objections here?

Yes, what I said in v5.

At one point this series had a user which was finding a matching node
by name. Now there is no user, so I can't really say whether this API
makes sense or not.

There's generally only 2 uses for 'name' at least for DT. The first is
node matching by name. ICYMI, every case of that in the tree is now
replaced with of_node_name_eq(). Now the details of matching by node
name are contained within the DT API. The 2nd use of node names is
just informational purposes or to fill some other structure's name
string (e.g. struct resource). In these cases, device_node.full_name
can be used. The only difference is full_name includes the unit
address ('@1234' part) if there is one. For these uses, the kernel
shouldn't generally care what the name actually is, but that's not
really enforceable.

Rob
