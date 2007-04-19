From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/22] ACPI: Cache battery status instead of
 re-evaluating AML
Date: Thu, 19 Apr 2007 11:23:13 -0700
Message-ID: <20070419112313.24e43271.akpm@linux-foundation.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
	<11734992652665-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:42012 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398AbXDSSe4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Apr 2007 14:34:56 -0400
In-Reply-To: <11734992652665-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

On Fri,  9 Mar 2007 23:00:42 -0500
Len Brown <lenb@kernel.org> wrote:

> From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
> 
> /proc exports _BST in a single file, and _BST is re-evaulated
> whenever that file is read.
> 
> Sometimes user-space reads this file frequently, and on some
> systems _BST takes a long time to evaluate due to a slow EC.
> 
> Further, when we move to sysfs, the values returned from _BST
> will be in multiple files, and evaluating _BST for each
> file read would make matters worse.
> 
> Here code is added to support caching the results of _BST.
> A new module parameter "update_time" tells how many seconds the
> cached _BST should be used before it is re-evaluated.
> Currently, update_time defaults to 0, and so the
> existing behaviour of re-evaluating on each read retained.
> 
> ...
>  
> +#define acpi_battery_present(battery) battery->device->status.battery_present
> +#define acpi_battery_present_prev(battery) battery->flags.battery_present_prev
> +#define acpi_battery_alarm_present(battery) battery->flags.alarm_present
> +#define acpi_battery_init_update_flag(battery) battery->flags.init_update
> +#define acpi_battery_info_update_flag(battery) battery->flags.info_update
> +#define acpi_battery_state_update_flag(battery) battery->flags.state_update
> +#define acpi_battery_alarm_update_flag(battery) battery->flags.alarm_update
> +#define acpi_battery_power_units(battery) battery->flags.power_unit ? \
> +		ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS
> +#define acpi_battery_handle(battery) battery->device->handle
> +#define acpi_battery_inserted(battery) (!acpi_battery_present_prev(battery) & acpi_battery_present(battery))
> +#define acpi_battery_removed(battery) (acpi_battery_present_prev(battery) & !acpi_battery_present(battery))
> +#define acpi_battery_bid(battery) acpi_device_bid(battery->device)
> +#define acpi_battery_status_str(battery) acpi_battery_present(battery) ? "present" : "absent"

These macros are

a) insufficiently parenthesised: try evaluating

	acpi_battery_present(battery + 1);

b) ugly.  It's a real bad sign when we see

	acpi_battery_init_update_flag(battery) = 1;

   which simply isn't C.

If we really insist on this obfuscation layer then it would be much better
to do

static inline int acpi_battery_init_update_flag(struct acpi_battery *battery)
{
	return battery->flags.init_update;
}

static inline void
acpi_battery_set_init_update_flag(struct acpi_battery *battery, int value)
{
	battery->flags.init_update = value;
}

> +static void acpi_battery_mutex_lock(struct acpi_battery *battery)
> +{
> +	mutex_lock(&battery->mutex);
> +}
> +
> +static void acpi_battery_mutex_unlock(struct acpi_battery *battery)
> +{
> +	mutex_unlock(&battery->mutex);
> +}

These wrappers don't add any value and should be removed.

> +static void acpi_battery_check_result(struct acpi_battery *battery, int result)
> +{
> +	if (!battery)
> +		return;
> +
> +	if (result) {
> +		acpi_battery_init_update_flag(battery) = 1;
> +	}
> +}

We prefer not to have braces around a single statement like this.

> +static int acpi_battery_extract_package(struct acpi_battery *battery,
> +					union acpi_object *package,
> +					struct acpi_buffer *format,
> +					struct acpi_buffer *data,
> +					char *package_name)
> +{
> +	acpi_status status = AE_OK;
> +	struct acpi_buffer data_null = { 0, NULL };
> +
> +	status = acpi_extract_package(package, format, &data_null);
> +	if (status != AE_BUFFER_OVERFLOW) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Extracting size %s",
> +				package_name));
> +		return -ENODEV;
> +	}
> +
> +	if (data_null.length != data->length) {
> +		if (data->pointer) {
> +			kfree(data->pointer);
> +		}

kfree(NULL) is legal and preferred kernel style is to not duplicate the
test fro NULL in the kfree() caller like this (there are multiple instances
of this in this patch).

> +		data->pointer = kzalloc(data_null.length, GFP_KERNEL);
> +		if (!data->pointer) {
> +			ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY, "kzalloc()"));
> +			return -ENOMEM;
> +		}
> +		data->length = data_null.length;
> +	}
> +
> +	status = acpi_extract_package(package, format, data);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Extracting %s",
> +				package_name));
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>
> ...
>
> +static int acpi_battery_read_info(struct seq_file *seq, void *offset)
> +{
> +	struct acpi_battery *battery = seq->private;
> +	int result = 0;
> +	int update_result = ACPI_BATTERY_NONE_UPDATE;
> +	int update = 0;
> +
> +	acpi_battery_mutex_lock(battery);
> +
> +	update = (get_seconds() - battery->info_update_time >= update_time);
> +	update = (update | acpi_battery_info_update_flag(battery));
> +
> +	result = acpi_battery_update(battery, update, &update_result);
> +	if (result)
> +		goto end;
> +
> +	/* Battery Info (_BIF) */
> +
> +	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
> +		result = acpi_battery_get_info(battery);
> +		if (result)
> +			goto end;
> +	}
> +
> +      end:
> +
> +	result = acpi_battery_read_info_print(seq, result);
> +
> +	acpi_battery_check_result(battery, result);
> +
> +	acpi_battery_info_update_flag(battery) = result;
> +
> +	acpi_battery_mutex_unlock(battery);
> +
> +	return result;
>  }

We have several copies of this function, each with tiny variations:

> +static int acpi_battery_read_state(struct seq_file *seq, void *offset)
> +{
> +	struct acpi_battery *battery = seq->private;
> +	int result = 0;
> +	int update_result = ACPI_BATTERY_NONE_UPDATE;
> +	int update = 0;
> +
> +	acpi_battery_mutex_lock(battery);
> +
> +	update = (get_seconds() - battery->state_update_time >= update_time);
> +	update = (update | acpi_battery_state_update_flag(battery));
> +
> +	result = acpi_battery_update(battery, update, &update_result);
> +	if (result)
> +		goto end;
> +
> +	/* Battery State (_BST) */
> +
> +	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
> +		result = acpi_battery_get_state(battery);
> +		if (result)
> +			goto end;
> +	}
> +
> +      end:
> +
> +	result = acpi_battery_read_state_print(seq, result);
> +
> +	acpi_battery_check_result(battery, result);
> +
> +	acpi_battery_state_update_flag(battery) = result;
> +
> +	acpi_battery_mutex_unlock(battery);
> +
> +	return result;
>  }

Can we not find a way of consolidating all this duplication?

> +static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
> +{
> +	struct acpi_battery *battery = seq->private;
> +	int result = 0;
> +	int update_result = ACPI_BATTERY_NONE_UPDATE;
> +	int update = 0;
> +
> +	acpi_battery_mutex_lock(battery);
> +
> +	update = (get_seconds() - battery->alarm_update_time >= update_time);
> +	update = (update | acpi_battery_alarm_update_flag(battery));
> +
> +	result = acpi_battery_update(battery, update, &update_result);
> +	if (result)
> +		goto end;
> +
> +	/* Battery Alarm */
> +
> +	if (update_result == ACPI_BATTERY_EASY_UPDATE) {
> +		result = acpi_battery_get_alarm(battery);
> +		if (result)
> +			goto end;
> +	}
> +
> +      end:
> +
> +	result = acpi_battery_read_alarm_print(seq, result);
> +
> +	acpi_battery_check_result(battery, result);
> +
> +	acpi_battery_alarm_update_flag(battery) = result;
> +
> +	acpi_battery_mutex_unlock(battery);
> +
> +	return result;
>  }

More here.


