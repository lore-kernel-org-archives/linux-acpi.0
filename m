From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] platform: x86: dell-laptop: Add support for keyboard
 backlight
Date: Fri, 21 Nov 2014 12:39:30 -0800
Message-ID: <20141121203930.GA74402@vmdeb7>
References: <1415967813-7223-1-git-send-email-pali.rohar@gmail.com>
 <20141119183416.GA100640@vmdeb7>
 <201411192141.20190@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58948 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbaKVSB2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Nov 2014 13:01:28 -0500
Content-Disposition: inline
In-Reply-To: <201411192141.20190@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, libsmbios-devel@lists.us.dell.com, Srinivas_G_Gowda@dell.com, Michael_E_Brown@dell.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>

On Wed, Nov 19, 2014 at 09:41:20PM +0100, Pali Roh=E1r wrote:
> Hello,

Hi Pali,

>=20
> I removed other lines so mail is not too long.
>=20
> On Wednesday 19 November 2014 19:34:16 Darren Hart wrote:
=2E..
> > > +}
> > > +
> > > +static unsigned int kbd_get_max_level(void)
> > > +{
> > > +	if (kbd_info.levels !=3D 0)
> > > +		return kbd_info.levels;
> >=20
> > This test.... does nothing? if it is 0, you still return 0
> > below :-)
> >=20
> > > +	if (kbd_mode_levels_count > 0)
> > > +		return kbd_mode_levels_count - 1;
> > > +	return 0;
> >=20
> > So the function is:
> >=20
> > return kbd_mode_levels_count > 0 ? kbd_mode_levels_count - 1 :
> > kbd_info.levels;
> >=20
> > The if blocks are more legible, so that's fine, but the first
> > one doesn't seem to do anything and you can replace the final
> > return with return kbd_info.levels.
> >=20
>=20
> There are two main way for setting keyboard backlight level. One=20
> is setting level register and other one is setting special=20
> keyboard mode. And some dell laptops support only first and some=20
> only second. So this code choose first available/valid method and=20
> then return correct data. I'm not sure if those two methods are=20
> only one and also do not know if in future there will be=20
> something other. Because of this I use code pattern:
>=20
> if (check_method_1) return value_method_1;
> if (check_method_2) return value_method_2;
> ...
> return unsupported;
>=20
> Same pattern logic is used in all functions which doing something=20
> with keyboard backlight level. (I will not other functions).

=46air enough. Clear, legible, consistent coding is preferable to a few=
 micro
optimizations that the compiler is likely to catch anyway. I withdraw t=
he
comment :-)

>=20
> > > +static int kbd_set_state(struct kbd_state *state)
> > > +{
> > > +	int ret;
> > > +
> > > +	get_buffer();
> > > +	buffer->input[0] =3D 0x2;
> > > +	buffer->input[1] =3D BIT(state->mode_bit) & 0xFFFF;
> > > +	buffer->input[1] |=3D (state->triggers & 0xFF) << 16;
> > > +	buffer->input[1] |=3D (state->timeout_value & 0x3F) << 24;
> > > +	buffer->input[1] |=3D (state->timeout_unit & 0x3) << 30;
> > > +	buffer->input[2] =3D state->als_setting & 0xFF;
> > > +	buffer->input[2] |=3D (state->level & 0xFF) << 16;
> > > +	dell_send_request(buffer, 4, 11);
> > > +	ret =3D buffer->output[0];
> > > +	release_buffer();
> > > +
> > > +	if (ret)
> > > +		return -EINVAL;
> >=20
> > Also, is EINVAL right here and elsewhere? Or did something
> > fail? EXIO?
> >=20
>=20
> According to Dell documentation, return value is stored in=20
> buffer->output[0] and can be:
>=20
> 0   Completed successfully
> -1  Completed with error
> -2  Function not supported
>=20
> So we can return something other too (not always -EINVAL). Do you=20
> have any idea which errno should we return for -1 and -2?

=46or -1, I should think  -EIO (I/O Error)
=46or -2, I'd expect -ENXIO (No such device or address)

Cc Rafael, Mika, linux-acpi in case they have a better idea.

>=20
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int kbd_set_state_safe(struct kbd_state *state,
> > > struct kbd_state *old) +{
> > > +	int ret;
> > > +
> > > +	ret =3D kbd_set_state(state);
> > > +	if (ret =3D=3D 0)
> > > +		return 0;
> > > +
> > > +	if (kbd_set_state(old))
> > > +		pr_err("Setting old previous keyboard state=20
> failed\n");
> >=20
> > And if we got an error and kbd_set_state(old) doesn't return
> > !0, what's the state of things? Still a failure a presume?
> >=20
>=20
> In some cases some laptops do not have to support everything. And=20
> when I (and Gabriele too) tried to set something unsupported Dell=20
> BIOS just resetted all settings to some default values. So this=20
> function try to set new state and if it fails then it try to=20
> restore previous settings.

OK, that deserves a comment then as the rationale isn't obvious.

>=20
> > > +
> > > +	return ret;
> > > +}
>=20
> > > +static void kbd_init(void)
> > > +{
> > > +	struct kbd_state state;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	ret =3D kbd_get_info(&kbd_info);
> > > +
> > > +	if (ret =3D=3D 0) {
> > > +
> >=20
> > Checking for success, let's invert and avoid the indentation
> > here too.
> >=20
>=20
> Again this is hard and not possible. This function first process=20
> data from kbd_get_info (if does not fail), then process data for=20
> kbd_tokens (via function find_token_id) and then set=20
> kbd_led_present to true if at least kbd_get_info or kbd_tokens=20
> succed.

The goal here is to avoid more than 3 levels of indentations for improv=
ed
legibility. Often there are logical inversions and such we can make to
accomplish this. When that fails, we break things up into functions, st=
atic
inlines, etc.

=46or reference:
https://lkml.org/lkml/2007/6/15/449

Which elaborates on CodingStyle Chapter 1: Indentation a bit.

=2E..
> > > +static ssize_t kbd_led_timeout_store(struct device *dev,
> > > +				     struct device_attribute *attr,
> > > +				     const char *buf, size_t count)
> > > +{
> > > +	struct kbd_state state;
> > > +	struct kbd_state new_state;
> > > +	int ret;
> > > +	bool convert;
> > > +	char ch;
> > > +	u8 unit;
> > > +	int value;
> > > +	int i;
> >=20
> > Decreasing line lenth please.
> >=20
>=20
> What do you mean?

This is a nit, but one other maintainers have imposed on me, as a means=
 to
improve legibility. The preference is to declare variables in decreasin=
g line
length, longest to shortest:

struct kbd_state new_state;
struct kbd_state state;
bool convert;
int value;
u8 unit;
char ch;
int ret;
int i;

This is a generalization and sometimes there are good reasons for doing
something else, such as logical groupings for commenting groups, etc. B=
ut since
this list appeared mostly random, defaulting to decreasing line length =
is
preferred.

>=20
> > > +	if (convert) {
> > > +		/* NOTE: this switch fall down */
> >=20
> > "fall down" ? As in, it intentionally doesn't have breaks?
> >=20
>=20
> This code convert "value" in "units" to new value in minutes=20
> units. So for unit =3D=3D days it is: 24*60*60... So no breaks.
>=20

Right, so the language of the comment just wasn't clear, try:

/* Convert value from seconds to minutes */

> > > +		switch (unit) {
> > > +		case KBD_TIMEOUT_DAYS:
> > > +			value *=3D 24;
> > > +		case KBD_TIMEOUT_HOURS:
> > > +			value *=3D 60;
> > > +		case KBD_TIMEOUT_MINUTES:
> > > +			value *=3D 60;
> > > +			unit =3D KBD_TIMEOUT_SECONDS;
> > > +	 	}
> > > +

--=20
Darren Hart
Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
