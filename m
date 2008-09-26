From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Is rfkill class really appropriate for eeepc-laptop?
Date: Fri, 26 Sep 2008 15:14:48 +0100
Message-ID: <48DCEE58.5060004@tuffmail.co.uk>
References: <20080918133144.GA4338@silver.sucs.org> <48D564A8.7030009@xandros.com> <20080921102246.GA27071@silver.sucs.org> <48D660C5.6070204@xandros.com> <48D69052.1040908@tuffmail.co.uk> <48D6AC5E.70502@xandros.com> <48DCE881.5000501@tuffmail.co.uk> <20080926135517.GA6273@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:38697 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYIZOOy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 10:14:54 -0400
Received: by nf-out-0910.google.com with SMTP id d3so361196nfc.21
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 07:14:52 -0700 (PDT)
In-Reply-To: <20080926135517.GA6273@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corentincj@iksaif.net, Woody Suwalski <woodys@xandros.com>, Sitsofe Wheeler <sits@sucs.org>, acpi4asus-user@lists.sourceforge.net, linux-acpi <linux-acpi@vger.kernel.org>

Matthew Garrett wrote:
> On Fri, Sep 26, 2008 at 02:49:53PM +0100, Alan Jenkins wrote:
>
>   
>> I was wrong to say that rfkill support was already in mainline.  But it
>> is introduced by Matthew's patch "eeepc-laptop: Use standard
>> interfaces", as posted and reviewed on the linux-acpi list.  I think
>> this is a bad idea.  Surely the whole point of rfkill is to let
>> NetworkManager do power management *without* having to do different
>> things for different laptops?
>>     
>
> No, it's to use allow the OS to control whatever mechanism the platform 
> provides for making the radio stop transmitting. The fact that this is, 
> uh, "interestingly" implemented on the Eee doesn't alter that.

So rfkill should be allowed to mean "entire PCI device goes away,
network interface will vanish" - just so long as it comes back correctly
when re-enabled :-).

>  We should just sort out the hotplug code...
>   

Ok.  I have a little knowledge, I'll see if I can be dangerous.  My real
question was, is it safe to merge your rfkill support before this is
sorted out?

Thanks
Alan
