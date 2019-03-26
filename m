From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Tue, 26 Mar 2019 14:11:35 +0100
Message-ID: <8c6accab-9e0c-c2d4-ce93-ea3ede60f34e@rasmusvillemoes.dk>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-7-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326124106.27694-7-sakari.ailus@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 26/03/2019 13.41, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.
> 
>  
> +static noinline_for_stack
> +char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> +		    struct printf_spec spec, const char *fmt)
> +{
> +	const char * const modifiers = "fP";
> +	struct printf_spec str_spec = spec;
> +	char *buf_start = buf;
> +	bool pass;
> +
> +	str_spec.field_width = -1;
> +
> +	if ((unsigned long)fwnode < PAGE_SIZE)
> +		return string(buf, end, "(null)", spec);
> +
> +	/* simple case without anything any more format specifiers */
> +	fmt++;
> +	if (fmt[0] == '\0' || strcspn(fmt, modifiers) > 0)
> +		fmt = "f";
> +
> +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
> +		if (pass) {
> +			if (buf < end)
> +				*buf = ':';
> +			buf++;
> +		}
> +
> +		switch (*fmt) {
> +		case 'f':	/* full_name */
> +			buf = fwnode_gen_full_name(fwnode, buf, end);
> +			break;
> +		case 'P':	/* name */
> +			buf = string(buf, end, fwnode_get_name(fwnode),
> +				     str_spec);
> +			break;
> +		default:
> +			break;
> +		}
> +	}

This seems awfully complicated. Why would anyone ever pass more than one
of 'f' and 'P'? Why not just

switch(*fmt) {
case 'P':
   ...
case 'f':
default:
   ...
}

which avoids the loop and the strcspn. Or, drop the default: case and
don't have logic at all for falling back to 'f' if neither is present.

> +	return widen_string(buf, buf - buf_start, end, spec);
> +}
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -1936,6 +1978,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>   *                  F device node flags
>   *                  c major compatible string
>   *                  C full compatible string
> + * - 'fw[fP]'	For a firmware node (struct fwnode_handle) pointer
> + *		Without an option prints the full name of the node
> + *		f full name
> + *		P node name, including a possible unit address
>   * - 'x' For printing the address. Equivalent to "%lx".
>   *
>   * ** When making changes please also update:
> @@ -2060,6 +2106,16 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  			return device_node_string(buf, end, ptr, spec, fmt + 1);
>  		}
>  		break;
> +	case 'f':
> +		switch (fmt[1]) {
> +		case 'w':
> +			return fwnode_string(buf, end, ptr, spec, fmt + 1);

Why not pass fmt+2; we know that fmt+1 points at a 'w'. Just to avoid
doing the fmt++ inside fwnode_string().

Rasmus
