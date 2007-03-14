From: Bret Hughes <bhughes@elevating.com>
Subject: Re: serial port discovery on a motion computing tablet
Date: Wed, 14 Mar 2007 18:57:23 -0500
Message-ID: <45F88BE3.8060702@elevating.com>
References: <45F7688B.8000101@elevating.com> <20070314134323.GC1467@srcf.ucam.org> <45F806B1.3060807@elevating.com> <20070314143534.GA2655@srcf.ucam.org> <45F80EAA.6010808@elevating.com> <20070314151441.GA3396@srcf.ucam.org> <45F817E2.1020900@elevating.com> <45F84103.8050803@elevating.com> <20070314232550.GA11970@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cleansurf.com ([64.207.224.120]:4146 "EHLO
	chopin.cleansurf.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422765AbXCOAIc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2007 20:08:32 -0400
In-Reply-To: <20070314232550.GA11970@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org



Matthew Garrett wrote:
> On Wed, Mar 14, 2007 at 01:37:55PM -0500, Bret Hughes wrote:
>
>   
>> Woo hoo! I see my device it's id is TKO0001 just like the engr told me 
>> it would be.  At the time I had little to no idea what he was talking about.
>>
>> On to look at the code and see how that works.
>>     
>
> Something like the following should work, if you haven't already got it 
> figured:
>
> diff --git a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
> index d3d6b82..c7b019b 100644
> --- a/drivers/serial/8250_pnp.c
> +++ b/drivers/serial/8250_pnp.c
> @@ -340,6 +340,8 @@ static const struct pnp_device_id pnp_dev_table[] = {
>  	{       "FUJ02B8",              0 },
>  	{       "FUJ02B9",              0 },
>  	{       "FUJ02BC",              0 },
> +	/* TouchKO touchscreen */
> +	{       "TKO0001",              0 },
>  	/* Rockwell's (PORALiNK) 33600 INT PNP */
>  	{	"WCI0003",		0	},
>  	/* Unkown PnP modems */
>
> and then just make sure that you have CONFIG_8250_PNP enabled. After 
> that, it should just appear as a touchscreen. You may still need to 
> perform some handshaking in the protocol interaction to get it working, 
> but ideally that would be done in the X driver.
>   
[root@localhost serial]# diff 8250_pnp.c.orig 8250_pnp.c                        326,327c326,329

<       /* Wacom tablets */

<       {       "WACF004",              0       },

---

>       /* TouchKO tablets */

>       {       "TKO0001",              0       },

>       /* wacom tablets */

>       {       "wacf004",              0       },



As you can see, that is almost exactly what I did.  Once I recompiled, 
the device came up attached to ttyS0 irq5 just like the windows side 
does.  I am struggling a bit to get to where I can send the command to 
place the controller into Microtouch mode.  There is a little perl prog 
I got from the TouchKo site to do that and I thought I could make it 
work but it is kicking my butt.  The controller comes up at 38400 and if 
my notes are correct, going into MT mode should drop it to 9600  and a 
reconfig of the port needs to occur to continue talking to it.  Right 
now I cannot get any response back in perl at all.

I CAN use minicom to ping the controller and I get the expected response 
'Pass' but can't figure out how to send 0x0D  0x01 FMT 0x0D.   IIRC this 
only has to happen once and the controller will remember what mode its 
in.  Once  get it working in linux I bet it will be broken in Windows 
until it gets reset.   Hmm have to think about that. I have a feeling I 
am going to have to write something to toggle this dude so we can switch 
back and forth.

I'll dig in tomorrow and get the engineer back on the horn to see if he 
can help.  Is this something that this driver could/should do?  Is there 
some other place that the kernel or a module can set this up so the user 
does not have to worry about it or is that beyond the scope of what is 
done in kernel space?

Once I get it working I'll post again with final details just so those 
that come behind me will have a chance of not reinventing the wheel but 
I think as far as the acpi side goes you got me going.

Thanks again.

Bret
