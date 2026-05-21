Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E24296BAF;
	Thu, 21 May 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371577; cv=none; b=hscjbAKk8Uq2j3BI39zpXwnQjHDfLSZQPgRErLnPpQtPspA7SSBIxYbYWEB4RjgRjPwiCjdTwUjcYaFTptZOoxdK0hJe/60fyQTLsXJQgwwYZY1s+kdXTd+yO1iHYnmZDnuioKkafeqdb0UTCiPRisWJLbgDwxH8TmKnnx00MKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371577; c=relaxed/simple;
	bh=OAwtVmKsfg7OJO4qnLNsI1wLj2SdChe9+x+295CjGrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1h5uF0gdzunIFU0T4j02dsgQ0F6dGN/+bufOjLRWuaXka14y5u/mFKpuZZ6iNudJXDl9mzWwgP372gPBkJyd0F9F+oV8nw1cJVLQdsuG4WI+mtx0UX+DNrbED4Fsylqm7anbPSRgonF/IhFZ27NLS5RL0F28SdgtSupkb6/D/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1BcEcmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1BcEcmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4C01F000E9;
	Thu, 21 May 2026 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371576;
	bh=IrKHcvZOqaB27+2COXlvDarPY+WfYhxwlLKAn/xf+SQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j1BcEcmya7ci1Qo0c9hGrhc/8C/YeA840wKgiFMxv20CYEK5HIL6cqejzfQ/lA+ba
	 2tebprE3AIR0QKT+SE7/Cqf4qWbm5Rj/WfzOO+4fvq6ipxwFrrIIJ2gZFuCYWociXx
	 uixf3jiYCGMMZmsctAeOItgg5NfrJshVF94Bmn5X8vtm1BIyT6HQWNPPQ9cPFmhe//
	 VuM4aa3xK54D3iEBc9Nw7zPwcVYyuCFxP+XfgBJrlIKchvAAKR/43YcSlgtojwrbWb
	 E68XyJZeTNpFEN1MNJhSPzSmxQRnvwtoBTKaLfI4FwZFsNaXmjG1fPOYH9+v47VIeY
	 Pc+J1M0gFFFeA==
Message-ID: <7d2f619c-5710-4c39-874b-aab230744014@kernel.org>
Date: Thu, 21 May 2026 08:52:54 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] ACPI: button: Fix ACPI GPE handler leak during
 removal
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
References: <5996185.DvuYhMxLoT@rafael.j.wysocki>
 <5103522.31r3eYUQgx@rafael.j.wysocki>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5103522.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/26 08:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit a7e23ec17fee ("ACPI: button: Install notifier for system events
> as well") changed the ACPI notify handler type for ACPI buttons to
> ACPI_ALL_NOTIFY, but it forgot to update acpi_button_remove() to reflect
> that change.  This leads to leaking the notify handler past driver
> removal, which may cause a kernel crash to occur if ACPI notify on
> the given device is triggered after removing the driver, and causes a
> subsequent probe of the given device with the same driver to fail.
> 
> Address this by updating the acpi_remove_notify_handler() call in
> acpi_button_remove() as appropriate.
> 
> Fixes: a7e23ec17fee ("ACPI: button: Install notifier for system events as well")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: 6.15+ <stable@vger.kernel.org> # 6.15+

Good catch, thanks.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/acpi/button.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -689,7 +689,7 @@ static void acpi_button_remove(struct pl
>   						acpi_button_event);
>   		break;
>   	default:
> -		acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
> +		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
>   					   button->type == ACPI_BUTTON_TYPE_LID ?
>   						acpi_lid_notify :
>   						acpi_button_notify);
> 
> 
> 

