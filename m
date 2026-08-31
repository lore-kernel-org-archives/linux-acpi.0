Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315E37F8A4;
	Mon, 31 Aug 2026 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207070; cv=none; b=Vmy80P87HUXUczyBm82ad1m2Sbo/QS5A+h2eBtaQVBBX5T+gOJwdj5yn5NVOtYSdaEe9yP3qOIaFaEDHqmL4AmxOeKAGykqA6nNuuO2RWqxcmukE48Jk81eX19kAlUV6sSn8Xnb7kI6PEyFqVRjFB/HZAU98MXWXpZEbkx0ypHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207070; c=relaxed/simple;
	bh=KPIRLw0SvrZCBjEAy+r8yDJ5iFZwtvTt5GVCFuOYVxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SN8bhBWA7qFDTI4RBtXtW+hcrglH0ggaZcQwUHbN/iRKV+4kbFWaC7aWBiy6Mz+T2jFZhcsXZopSXUG8jwhsWAjgUl7sQ0K83G+bdNEf51h/K4drY5c22GnxZGU9EfRjKT6h8wDN8PV+Mr3H6igtyENBi4qot2nCzKW+YVXJMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGjFzB3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGjFzB3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90E81F000E9;
	Mon, 31 Aug 2026 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207068;
	bh=lzDoYyhp0ZuoIKf1x1SwLSSxdL235qydHc5uFn07PfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nGjFzB3DUsqTvWPmLVOM+RBF8Cea9R8lNkGgPvM5wx30FLrveVU0zlzx/GyQNuRN+
	 7fI0tW0OShaWA61HyfyHbuqN6w87HkxqU0G2PPL6vDqXoSmtF0F0vtz4jE4UOrz8Cv
	 JqYCCJH9qYH3pqQZsGrg1Q6gkkhMulvnj9JKTX1uHx7BzxmMuOeZh0by/3EzzpQO98
	 n5Et3dcj8lVFIHuoamykRDv7pRyiJv8yqAxW5gcK4CUf6l+BQaE2IRbnKu0S/KORxH
	 Lgv3dibjmoo6Y9ioMpxxXXOOAH23OoTOrybCZbrUFEF0F9TBCFGGIXlNCur/kvwVA9
	 pesFV6smt16WA==
Message-ID: <a5c22e78-d78e-4306-8f70-3d0aff29a6e8@kernel.org>
Date: Mon, 31 Aug 2026 22:11:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: bus: Drop two fields from struct acpi_device_pnp
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <6314925.lOV4Wx5bFT@rafael.j.wysocki>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <6314925.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 31-Aug-26 22:07, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> There are two fields in struct acpi_device_pnp, device_name and
> device_class, that were supposed to be populated and used by device
> drivers, but they have never been used consistently and now they
> are only set for the bus object in acpi_set_pnp_ids() (and never
> read afterward).
> 
> Drop them along with all of the associated symbols except for
> MAX_ACPI_CLASS_NAME_LEN and the acpi_device_class typedef that
> are used by the ACPI netlink messaging code.  Move those two
> definitions closer to the struct acpi_bus_event that refers to
> the acpi_device_class type.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Nice :)  Patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/acpi/scan.c     |    4 ----
>  include/acpi/acpi_bus.h |   11 +++--------
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -28,9 +28,7 @@
>  #include "internal.h"
>  #include "sleep.h"
>  
> -#define ACPI_BUS_CLASS			"system_bus"
>  #define ACPI_BUS_HID			"LNXSYBUS"
> -#define ACPI_BUS_DEVICE_NAME		"System Bus"
>  
>  #define INVALID_ACPI_HANDLE	((acpi_handle)ZERO_PAGE(0))
>  
> @@ -1446,8 +1444,6 @@ static void acpi_set_pnp_ids(acpi_handle
>  			 acpi_object_is_system_bus(handle)) {
>  			/* \_SB, \_TZ, LNXSYBUS */
>  			acpi_add_id(pnp, ACPI_BUS_HID);
> -			strscpy(pnp->device_name, ACPI_BUS_DEVICE_NAME);
> -			strscpy(pnp->device_class, ACPI_BUS_CLASS);
>  		}
>  
>  		break;
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -206,12 +206,8 @@ struct acpi_device_dir {
>  
>  /* Plug and Play */
>  
> -#define MAX_ACPI_DEVICE_NAME_LEN	40
> -#define MAX_ACPI_CLASS_NAME_LEN		20
>  typedef char acpi_bus_id[8];
>  typedef u64 acpi_bus_address;
> -typedef char acpi_device_name[MAX_ACPI_DEVICE_NAME_LEN];
> -typedef char acpi_device_class[MAX_ACPI_CLASS_NAME_LEN];
>  
>  struct acpi_hardware_id {
>  	struct list_head list;
> @@ -233,16 +229,12 @@ struct acpi_device_pnp {
>  	acpi_bus_address bus_address;	/* _ADR */
>  	char *unique_id;		/* _UID */
>  	struct list_head ids;		/* _HID and _CIDs */
> -	acpi_device_name device_name;	/* Driver-determined */
> -	acpi_device_class device_class;	/*        "          */
>  };
>  
>  #define acpi_device_bid(d)	((d)->pnp.bus_id)
>  #define acpi_device_adr(d)	((d)->pnp.bus_address)
>  const char *acpi_device_hid(struct acpi_device *device);
>  #define acpi_device_uid(d)	((d)->pnp.unique_id)
> -#define acpi_device_name(d)	((d)->pnp.device_name)
> -#define acpi_device_class(d)	((d)->pnp.device_class)
>  
>  /* Power Management */
>  
> @@ -582,6 +574,9 @@ int acpi_dev_for_each_child_reverse(stru
>   * ------
>   */
>  
> +#define MAX_ACPI_CLASS_NAME_LEN		20
> +typedef char acpi_device_class[MAX_ACPI_CLASS_NAME_LEN];
> +
>  struct acpi_bus_event {
>  	struct list_head node;
>  	acpi_device_class device_class;
> 
> 
> 

