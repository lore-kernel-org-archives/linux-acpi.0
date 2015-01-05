From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] acpi: acpica: utstate:  Remove unused function
Date: Mon, 5 Jan 2015 08:39:37 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026AACAC@SHSMSX101.ccr.corp.intel.com>
References: <1420232480-3252-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27650 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbbAEIjs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jan 2015 03:39:48 -0500
In-Reply-To: <1420232480-3252-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, "Moore, Robert" <robert.moore@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Richard

> From: Rickard Strandqvist [mailto:rickard_strandqvist@spectrumdigital.se]
> Sent: Saturday, January 03, 2015 5:01 AM
> 
> Remove the function acpi_ut_create_pkg_state_and_push() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.

acpi_ut_create_pkg_state_and_push() is not even used in ACPICA.
We can remove it now.

Thanks and best regards
-Lv

> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/acpi/acpica/acutils.h |    8 --------
>  drivers/acpi/acpica/utstate.c |   33 ---------------------------------
>  2 files changed, 41 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
> index 486d342..ef2ad3c 100644
> --- a/drivers/acpi/acpica/acutils.h
> +++ b/drivers/acpi/acpica/acutils.h
> @@ -539,14 +539,6 @@ acpi_ut_create_update_state_and_push(union acpi_operand_object *object,
>  				     u16 action,
>  				     union acpi_generic_state **state_list);
> 
> -#ifdef	ACPI_FUTURE_USAGE
> -acpi_status
> -acpi_ut_create_pkg_state_and_push(void *internal_object,
> -				  void *external_object,
> -				  u16 index,
> -				  union acpi_generic_state **state_list);
> -#endif				/* ACPI_FUTURE_USAGE */
> -
>  union acpi_generic_state *acpi_ut_create_control_state(void);
> 
>  void acpi_ut_delete_generic_state(union acpi_generic_state *state);
> diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
> index 1cc97a7..fa932e9 100644
> --- a/drivers/acpi/acpica/utstate.c
> +++ b/drivers/acpi/acpica/utstate.c
> @@ -49,39 +49,6 @@ ACPI_MODULE_NAME("utstate")
> 
>  /*******************************************************************************
>   *
> - * FUNCTION:    acpi_ut_create_pkg_state_and_push
> - *
> - * PARAMETERS:  object          - Object to be added to the new state
> - *              action          - Increment/Decrement
> - *              state_list      - List the state will be added to
> - *
> - * RETURN:      Status
> - *
> - * DESCRIPTION: Create a new state and push it
> - *
> - ******************************************************************************/
> -acpi_status
> -acpi_ut_create_pkg_state_and_push(void *internal_object,
> -				  void *external_object,
> -				  u16 index,
> -				  union acpi_generic_state **state_list)
> -{
> -	union acpi_generic_state *state;
> -
> -	ACPI_FUNCTION_ENTRY();
> -
> -	state =
> -	    acpi_ut_create_pkg_state(internal_object, external_object, index);
> -	if (!state) {
> -		return (AE_NO_MEMORY);
> -	}
> -
> -	acpi_ut_push_generic_state(state_list, state);
> -	return (AE_OK);
> -}
> -
> -/*******************************************************************************
> - *
>   * FUNCTION:    acpi_ut_push_generic_state
>   *
>   * PARAMETERS:  list_head           - Head of the state stack
> --
> 1.7.10.4

