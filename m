From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/11] ACPICA: Events: Fix acpi_ev_initialize_region()
 return value
Date: Thu, 1 Dec 2016 14:30:58 +0100
Message-ID: <CAJZ5v0gBLvW0QawtGfQNF0Z_Dg7FOX3SN7+paJoxmrms=U-85g@mail.gmail.com>
References: <cover.1480490191.git.lv.zheng@intel.com> <e70ef2444fb571fa7c6642c56f9d49333143b60c.1480490191.git.lv.zheng@intel.com>
 <CAJZ5v0j50UvtnzzYKaQ=KUSO7SCOzU_DooVE+hbMznQ-sQ0yHQ@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886A297699@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34361 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759016AbcLANbA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 08:31:00 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A297699@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Thu, Dec 1, 2016 at 9:00 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
>> Wysocki
>> Subject: Re: [PATCH 04/11] ACPICA: Events: Fix acpi_ev_initialize_region() return value
>>
>> On Wed, Nov 30, 2016 at 8:21 AM, Lv Zheng <lv.zheng@intel.com> wrote:
>> > ACPICA commit 543342ab7a676f4eb0c9f100d349388a84dff0e8
>> >
>> > This patch changes acpi_ev_initialize_region(), stop returning AE_NOT_EXIST
>> > from it so that, not only in acpi_ds_load2_end_op(), but all places invoking
>> > this function won't emit exceptions. The exception can be seen in
>> > acpi_ds_initialize_objects() when certain table loading mode is chosen.
>> >
>> > This patch also removes useless acpi_ns_locked from acpi_ev_initialize_region()
>> > as this function will always be invoked with interpreter lock held now, and
>> > the lock granularity has been tuned to lock around _REG execution, thus it
>> > is now handled by acpi_ex_exit_interpreter(). Lv Zheng.
>> >
>> > Link: https://github.com/acpica/acpica/commit/543342ab
>> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> > Signed-off-by: Bob Moore <robert.moore@intel.com>
>> > ---
>> >  drivers/acpi/acpica/acevents.h |    4 +--
>> >  drivers/acpi/acpica/dsopcode.c |    2 +-
>> >  drivers/acpi/acpica/dswload2.c |   13 +--------
>> >  drivers/acpi/acpica/evrgnini.c |   59 ++++++++++++++++------------------------
>> >  4 files changed, 27 insertions(+), 51 deletions(-)
>> >
>> > diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
>> > index 92fa47c..8a0049d 100644
>> > --- a/drivers/acpi/acpica/acevents.h
>> > +++ b/drivers/acpi/acpica/acevents.h
>> > @@ -243,9 +243,7 @@ union acpi_operand_object *acpi_ev_find_region_handler(acpi_adr_space_type
>> >                              u32 function,
>> >                              void *handler_context, void **region_context);
>> >
>> > -acpi_status
>> > -acpi_ev_initialize_region(union acpi_operand_object *region_obj,
>> > -                         u8 acpi_ns_locked);
>> > +acpi_status acpi_ev_initialize_region(union acpi_operand_object *region_obj);
>> >
>> >  /*
>> >   * evsci - SCI (System Control Interrupt) handling/dispatch
>> > diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
>> > index 4cc9d98..77fd7c8 100644
>> > --- a/drivers/acpi/acpica/dsopcode.c
>> > +++ b/drivers/acpi/acpica/dsopcode.c
>> > @@ -84,7 +84,7 @@ acpi_status acpi_ds_initialize_region(acpi_handle obj_handle)
>> >
>> >         /* Namespace is NOT locked */
>> >
>> > -       status = acpi_ev_initialize_region(obj_desc, FALSE);
>> > +       status = acpi_ev_initialize_region(obj_desc);
>> >         return (status);
>> >  }
>> >
>> > diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
>> > index e362182..651f35a 100644
>> > --- a/drivers/acpi/acpica/dswload2.c
>> > +++ b/drivers/acpi/acpica/dswload2.c
>> > @@ -609,18 +609,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
>> >
>> >                         status =
>> >                             acpi_ev_initialize_region
>> > -                           (acpi_ns_get_attached_object(node), FALSE);
>> > -
>> > -                       if (ACPI_FAILURE(status)) {
>> > -                               /*
>> > -                                *  If AE_NOT_EXIST is returned, it is not fatal
>> > -                                *  because many regions get created before a handler
>> > -                                *  is installed for said region.
>> > -                                */
>> > -                               if (AE_NOT_EXIST == status) {
>> > -                                       status = AE_OK;
>> > -                               }
>> > -                       }
>> > +                           (acpi_ns_get_attached_object(node));
>>
>> This hunk doesn't apply for me.
>>
>> We have acpi_ex_exit_interpreter() / acpi_ex_enter_interpreter()
>> around the acpi_ev_initialize_region() in linux-next.
>
> This commit only changes returning value.
> Lock changes are not included.
>
> We never invokes acpi_ev_initialize_region with acpi_ns_locked=true.
> So all if (acpi_ns_locked) code pieces are useless and deleted in this commit.
>
>>
>> >                         break;
>> >
>> >                 case AML_NAME_OP:
>> > diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
>> > index 75ddd16..a909225 100644
>> > --- a/drivers/acpi/acpica/evrgnini.c
>> > +++ b/drivers/acpi/acpica/evrgnini.c
>> > @@ -479,7 +479,6 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
>> >   * FUNCTION:    acpi_ev_initialize_region
>> >   *
>> >   * PARAMETERS:  region_obj      - Region we are initializing
>> > - *              acpi_ns_locked  - Is namespace locked?
>> >   *
>> >   * RETURN:      Status
>> >   *
>> > @@ -497,19 +496,28 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
>> >   * MUTEX:       Interpreter should be unlocked, because we may run the _REG
>> >   *              method for this region.
>> >   *
>> > + * NOTE:        Possible incompliance:
>> > + *              There is a behavior conflict in automatic _REG execution:
>> > + *              1. When the interpreter is evaluating a method, we can only
>> > + *                 automatically run _REG for the following case:
>> > + *                   operation_region (OPR1, 0x80, 0x1000010, 0x4)
>> > + *              2. When the interpreter is loading a table, we can also
>> > + *                 automatically run _REG for the following case:
>> > + *                   operation_region (OPR1, 0x80, 0x1000010, 0x4)
>> > + *              Though this may not be compliant to the de-facto standard, the
>> > + *              logic is kept in order not to trigger regressions. And keeping
>> > + *              this logic should be taken care by the caller of this function.
>> > + *
>> >   ******************************************************************************/
>> >
>> > -acpi_status
>> > -acpi_ev_initialize_region(union acpi_operand_object *region_obj,
>> > -                         u8 acpi_ns_locked)
>> > +acpi_status acpi_ev_initialize_region(union acpi_operand_object *region_obj)
>> >  {
>> >         union acpi_operand_object *handler_obj;
>> >         union acpi_operand_object *obj_desc;
>> >         acpi_adr_space_type space_id;
>> >         struct acpi_namespace_node *node;
>> > -       acpi_status status;
>> >
>> > -       ACPI_FUNCTION_TRACE_U32(ev_initialize_region, acpi_ns_locked);
>> > +       ACPI_FUNCTION_TRACE(ev_initialize_region);
>> >
>> >         if (!region_obj) {
>> >                 return_ACPI_STATUS(AE_BAD_PARAMETER);
>> > @@ -580,39 +588,17 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
>> >                                                   handler_obj, region_obj,
>> >                                                   obj_desc));
>> >
>> > -                               status =
>> > -                                   acpi_ev_attach_region(handler_obj,
>> > -                                                         region_obj,
>> > -                                                         acpi_ns_locked);
>> > +                               (void)acpi_ev_attach_region(handler_obj,
>> > +                                                           region_obj, FALSE);
>> >
>> >                                 /*
>> >                                  * Tell all users that this region is usable by
>> >                                  * running the _REG method
>> >                                  */
>> > -                               if (acpi_ns_locked) {
>> > -                                       status =
>> > -                                           acpi_ut_release_mutex
>> > -                                           (ACPI_MTX_NAMESPACE);
>> > -                                       if (ACPI_FAILURE(status)) {
>> > -                                               return_ACPI_STATUS(status);
>> > -                                       }
>> > -                               }
>> > -
>> >                                 acpi_ex_exit_interpreter();
>> > -                               status =
>> > -                                   acpi_ev_execute_reg_method(region_obj,
>> > -                                                              ACPI_REG_CONNECT);
>> > +                               (void)acpi_ev_execute_reg_method(region_obj,
>> > +                                                                ACPI_REG_CONNECT);
>> >                                 acpi_ex_enter_interpreter();
>>
>> And this also doesn't apply, because we don't invoke
>> acpi_ex_exit_interpreter() / acpi_ex_enter_interpreter() around the
>> acpi_ev_execute_reg_method() call in linux-next.
>>
>
> acpi_ex_exit_interpreter() / acpi_ex_enter_interpreter() are not-modified-lines.
> Please check again.

As I said in the previous message, this was a result of my mistake.

Fixed now and everything applies as it should.

Thanks,
Rafael
