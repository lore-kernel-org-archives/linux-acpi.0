Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591025;
	b=o7sfvEB44n1q7xYai2+7/0qzSyfoC7+fLilp7BkckTKfZ2hwTyRxAERo81GHnhEYrcgu
	 EYJaSSJs+cYETde0qnnjI7OozKIvkmz+GIgF9cLGI/dTMBbfkeDsXHFxG17FeHJSrMakE
	 5bnLwoqs5hKkUWRxYgGmrbnxcUBkwSFhE4BcryEWsjkSETY4vojqYL7UqvMEXkqhNaBYQ
	 qSoT/kkbVt3uF1rwLRc0h0GX+NpgErqkmGseGacvKylY868MuxI6mqc4LONtolyo8EHfG
	 k7Eth4RaBKp0rIlv62Q7iCq31qcjbA/L7+3opOFChBCsTbt5cOctLQn40v+OHaXgc2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591025;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:MIME-Version:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Report:X-Spam-Score:
	 X-Spam-Bar:X-Rspamd-Score:X-Rspamd-Action:X-Rspamd-Bar;
	bh=OMyr6xNemxo9sermmgznNBCBoRJBZstiR7VSTiFQ0gs=;
	b=EB30gQraTapmHQfQLrvGBH+y4l/Xmx1CQ0cPGAyRYKyVlu2UzakTQgIX+2NiV63ZhWvx
	 Rd78D+vKhf1kEbeRzKTM+Bj2xUuFATB3Wv8Cyx3v5ncEyLHWcX0wYrX78zn3PE6he2R+y
	 zFeBAXJcyEhbhRSZ+9+ys2qILNqcTGng5SlWTHR9NMh4tiVS/5yEwKgY/Fl5MZjmmPmUh
	 H+2j6uqKl+H03/uM2UdKN/kt1yV9nQT7XRMzfCnIxr2/B+YVI/+dBAWgboWq72QBBHoWn
	 PaKsiKRgcTKX+dUryBOFG9KuaEviVrvk4/28FG3evzystm9OIwZgKysbH907jqu8h+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=TuxOcSgh;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B92606E657;
	Fri, 13 Nov 2026 17:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B92606E657
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=TuxOcSgh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=OMyr6xNemxo9sermmgznNBCBoRJBZstiR7VSTiFQ0gs=; t=1794591024; x=2109951024; 
	b=TuxOcSghmKCCbNyYYZ6ERTcZVChakEv3eoSXxsvEQnFxopeguUGvgrbmgZZ0jML9t4NEvtgbPrQ
	d6qJbic3Y73sXYHdkLFBC7ZeW4Q4nz+HKCPr1dJCh1owvBGD93fg4P7vOYLEf3NzsJ7urAlZTif5W
	tK6IsrWueIDB4pEu7/o/9t+RVuffrzcQEH2DsbyQ/xQCYqS8vjDEmKznE9CVT5LrSz/wg2UOlaa8+
	BvsPPHQriO4uAU/DCHZE1EU+MznYC2GxfswwneFWQcquOx9gM9vBRNYEvwMf6okch6wyCqW4H/1l/
	CLwCyOkHLcpnG5STMq1QnBaqP/WzzOZYCpYg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xRv6T-00AHrc-Uq; Fri, 13 Nov 2026 18:30:21 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xRv6T-0000000Cijf-11XC;
	Fri, 13 Nov 2026 18:30:21 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <uajain@igalia.com>)
	id 1xRv6T-0000000HQwg-0T6Z;
	Fri, 13 Nov 2026 18:30:21 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 17:30:21 +0000
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 2/2] acpi: battery: Read Battery charge time for
 Steamdeck devices
In-Reply-To: <CAJZ5v0htK7MdRQ3N+bNhzR5uvfxtS7g1mPvQwr1yQsoJ7qM66A@mail.gmail.com>
References: <20261014204558.466130-1-uajain@igalia.com>
 <20261014204558.466130-3-uajain@igalia.com>
 <CAJZ5v0htK7MdRQ3N+bNhzR5uvfxtS7g1mPvQwr1yQsoJ7qM66A@mail.gmail.com>
Message-ID: <a4c3bc202e8c1bf3a0e4df48fc584397@igalia.com>
X-Sender: uajain@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.007
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -2.8
X-Rspamd-Action: no action
X-Rspamd-Bar: --

Hi Rafael,

Thanks for the review

On 2026-11-09 18:22, Rafael J. Wysocki (Intel) wrote:
> On Wed, Oct 14, 2026 at 10:44 PM Umang Jain <uajain@igalia.com> wrote:
>>
>> Valve steamdeck devices can report battery status as
>> charging, even when low-powered power supply is connected
>> to the device. The battery status is reported as charging
>> through sysfs, even though in reality, it is discharging.
>>
>> To handle this case, read out Battery charge time ("_BCT")
>> as it is reported accurately on these devices, hence use that
>> information for report charging vs discharging status.
>> Battery charge time ("_BCT") with an eligible power supply unit
>> will have valid values whereas with a low-powered supply unit,
>> it shall report ACPI_BATTERY_VALUE_UNKNOWN. Use this as a
>> differentiator to determine, whether the battery of steamdeck
>> devices is really charging or not.
>>
>> Signed-off-by: Umang Jain <uajain@igalia.com>
> 
> I think that it would be better to merge this patch with the [1/2].
> 
>> ---
>>  drivers/acpi/battery.c | 25 ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index fa20900bea0e..b7818695b6cb 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -242,7 +242,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>                                         : POWER_SUPPLY_STATUS_DISCHARGING;
>>                                 return 0;
>>                         }
>> -               else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>> +               else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
>>                         /* Check the rate and capacity to validate the status. */
>>                         if (!acpi_battery_is_full(battery) ||
>>                             (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
>> @@ -252,6 +252,29 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>                                 /* Full and zero rate. */
>>                                 val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>                         }
>> +
>> +                       /*
>> +                        * For Valve Steamdeck devices, evaluate _BCT to determine
>> +                        * if we are really charging.
>> +                        */
>> +                       if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags) &&
>> +                           acpi_has_method(battery->device->handle, "_BCT")) {
> 
> Can you check the _BCT presence at the time when the quirk bit is set
> and avoid setting the bit when _BCT is not present?  That would allow
> you to just test the bit here.
> 
>> +                               unsigned long long bct;
>> +                               acpi_status status;
>> +                               union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>> +                               struct acpi_object_list args = { 1, &arg0 };
>> +
>> +                               arg0.integer.value = 100;
>> +                               status = acpi_evaluate_integer(battery->device->handle, "_BCT",
>> +                                                              &args, &bct);
>> +                               if (ACPI_FAILURE(status) || bct > ACPI_UINT32_MAX)
>> +                                       acpi_handle_info(battery->device->handle,
> 
> This should be acpi_handle_debug(), but I'm not sure if this message
> is interesting at all, especially if _BCT fails every time.  Also, it
> may be confusing in the bct > ACPI_UINT32_MAX case because it may
> print "success" then.

Agree with the ACPI_UINT32_MAX comment. I would like to keep the message
with acpi_handle_debug and split the if branch to handle the bct >
ACPI_UINT32_MAX separately. In this case, I won't print the
acpi_format_exception(status) and simply write that bct value is just
invalid. How does that sound?

Thanks.

> 
>> +                                                        "_BCT evaluation failed: %s",
>> +                                                        acpi_format_exception(status));
>> +                               else if (bct == ACPI_BATTERY_VALUE_UNKNOWN)
>> +                                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>> +                       }
>> +               }
>>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
>>                         val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>                 else if (acpi_battery_is_charged(battery))
>> --
