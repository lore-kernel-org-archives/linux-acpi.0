From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] acer-wmi: Add rfkill support for wireless and bluetooth
	(v4)
Date: Fri, 12 Sep 2008 16:43:09 -0400
Message-ID: <20080912164039.ZZRA012@mailhub.coreip.homeip.net>
References: <200808301206.56279.carlos@strangeworlds.co.uk> <200809071813.23730.carlos@strangeworlds.co.uk> <20080908032953.GA26459@khazad-dum.debian.net> <200809122044.27418.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200809122044.27418.carlos-8YloKY0SPvpS8uBCpOlSjPXRex20P6io@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carlos Corbacho <carlos-8YloKY0SPvpS8uBCpOlSjPXRex20P6io@public.gmane.org>
Cc: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Carlos,

On Fri, Sep 12, 2008 at 08:44:26PM +0100, Carlos Corbacho wrote:
> +
> +static int acer_rfkill_register(struct device *dev, struct rfkill **rfkill_dev,
> +enum rfkill_type type, char *name, u32 cap)
> +{
> +	int err;
> +	u32 state;
> +	u32 *data;
> +
> +	*rfkill_dev = rfkill_allocate(dev, type);
> +	if (!*rfkill_dev)
> +		return -ENOMEM;
> +	(*rfkill_dev)->name = name;
> +	get_u32(&state, cap);
> +	(*rfkill_dev)->state = state ? RFKILL_STATE_UNBLOCKED :
> +		RFKILL_STATE_SOFT_BLOCKED;
> +	data = kzalloc(sizeof(u32), GFP_KERNEL);
> +	if (!data) {
> +		rfkill_free(*rfkill_dev);
> +		return -ENOMEM;
> +	}
> +	*data = cap;
> +	(*rfkill_dev)->data = data;
> +	(*rfkill_dev)->toggle_radio = acer_rfkill_set;
> +	(*rfkill_dev)->user_claim_unsupported = 1;
> +
> +	err = rfkill_register(*rfkill_dev);
> +	if (err) {
> +		kfree((*rfkill_dev)->data);
> +		rfkill_free(*rfkill_dev);
> +		return err;
> +	}
> +	return 0;
> +}
> +

Sorry if I am late to the party but this function is best to have
'struct rfkill *' return value and use ERR_PTR() to signal errors.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
