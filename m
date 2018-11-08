From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Date: Thu, 8 Nov 2018 12:23:51 -0600
Message-ID: <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com> <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This implements get_name fwnode op for DT.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/of/property.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index f46828e3b082..9bc8fe136fa3 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
>         of_node_put(to_of_node(fwnode));
>  }
>
> +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> +{
> +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> +       size_t len = strchrnul(name, '@') - name;
> +
> +       snprintf(buf, len + 1, "%s", name);

This can be simplified to:

snprintf(..., "%pOFn", to_of_node(fwnode))

But that presents a problem with knowing the length. Not passing in
the buf length is not good design because you can't tell if you
overflow the buffer. Either you can pass in the length of buf or do
the allocation here. In the latter case, then you can use kasnprintf.
The downside to doing the allocation here is then get_name() has side
effect of allocating memory that the caller needs to be aware of.

However, I think the current API is better. It leaves low-level
details up to the firmware implementation. But as long as .get_name()
is not exposed to drivers I don't really care that much.

Rob
