From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Add mutex to avoid race condition of reference
 count of notify object
Date: Wed, 18 Jun 2014 04:42:13 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880262E69D@SHSMSX101.ccr.corp.intel.com>
References: <1402884715-25049-1-git-send-email-jlee@suse.com>
 <1AE640813FDE7649BE1B193DEA596E880262DB43@SHSMSX101.ccr.corp.intel.com>
 <20140616091415.GF15540@linux-rxt1.site>
 <1AE640813FDE7649BE1B193DEA596E880262DE9C@SHSMSX101.ccr.corp.intel.com>
 <20140617091917.GJ15540@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18384 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbaFREmS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 00:42:18 -0400
In-Reply-To: <20140617091917.GJ15540@linux-rxt1.site>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: joeyli [mailto:jlee@suse.com]
> Sent: Tuesday, June 17, 2014 5:19 PM
> 
> On Tue, Jun 17, 2014 at 01:03:28AM +0000, Zheng, Lv wrote:
> > Hi,
> >
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of joeyli
> > > Sent: Monday, June 16, 2014 5:14 PM
> > >
> > > Hi Lv Zheng,
> > >
> > > Thanks for your response.
> > >
> > > On Mon, Jun 16, 2014 at 05:10:29AM +0000, Zheng, Lv wrote:
> > > > Hi,
> > > >
> > > > > From: Lee, Chun-Yi [mailto:joeyli.kernel@gmail.com]
> > > > > Sent: Monday, June 16, 2014 10:12 AM
> > > > >
> > > > > This issue found on v3.0 kernel, unfortunately there was no chance
> > > > > to test latest kernel on issue mchine. This patch tested on v3.0 kernel
> > > > > then sent to linux-acpi for review and note, maybe latest kernel also need.
> > > > >
> > > > > The problem happened when acpi thermal driver evaluate _PSL, but acpi
> > > > > processor driver install notify handler at the same time. In the
> > > > > code path of evaluate _PSL, it updates reference count of processor
> > > > > and its notify objects. When the notify handler installation done
> > > > > after the reference count of processor updated, it causes the
> > > > > ref_count of processor doesn't sync with its notify object's
> > > > > ref_count value.
> > > > >
> > > > > Here is an debugging log when issue reproduced:
> > > > >
> > > > > [    3.481773] ACPI_TYPE_PROCESSOR set ACPI_DEVICE_NOTIFY, object_desc->common.reference_count: 3, notify_obj-
> > > > > >common.reference_count: 1
> > > > > [    3.481958] PROCESSOR device_hid: LNXCPU
> > > > > ...
> > > > > [    3.487427] ACPI_TYPE_PROCESSOR, action = 1
> > > > > [    3.487428] Update device_notify ref_count
> > > > > [    3.487429] REF_DECREMENT ACPI_TYPE_LOCAL_NOTIFY original_count: 0
> > > > > [    3.487431] ACPI Warning: Obj ffff8800b0f40b28, Reference Count is already zero, cannot decrement
> > > > > [    3.487433]  (20110413/utdelete-431)
> > > > > [    3.487434] REF_DECREMENT ACPI_TYPE_PROCESSOR original_count: 2
> > > > >
> > > > > Accroding log, found the reference_count of parent object
> > > > > (it's processor in this case) is 3, it doesn't match with notify_object's
> > > > > reference_count, value is 1. It triggered "Reference Count is already zero"
> > > > > warning, then happen object double free issue later.
> > > > >
> > > > > To avoid rece condition, this patch introded ACPI_MTX_NOTIFY_REF_COUNT
> > > > > mutex to keep the ref_count of notify object sync with its parent
> > > > > object. And, it also set the reference_count value of new notify object
> > > > > equals to its parent object's reference_count.
> > > > >
> > > > > Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> > > > > ---
> > > > >  drivers/acpi/acpica/aclocal.h  | 3 ++-
> > > > >  drivers/acpi/acpica/evxface.c  | 7 ++++++-
> > > > >  drivers/acpi/acpica/utdelete.c | 6 ++++++
> > > > >  3 files changed, 14 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> > > > > index c7f743c..e25a4af 100644
> > > > > --- a/drivers/acpi/acpica/aclocal.h
> > > > > +++ b/drivers/acpi/acpica/aclocal.h
> > > > > @@ -85,8 +85,9 @@ union acpi_parse_object;
> > > > >  #define ACPI_MTX_MEMORY                 5	/* Debug memory tracking lists */
> > > > >  #define ACPI_MTX_DEBUG_CMD_COMPLETE     6	/* AML debugger */
> > > > >  #define ACPI_MTX_DEBUG_CMD_READY        7	/* AML debugger */
> > > > > +#define ACPI_MTX_NOTIFY_REF_COUNT	8	/* Reference count of notify object */
> > > > >
> > > > > -#define ACPI_MAX_MUTEX                  7
> > > > > +#define ACPI_MAX_MUTEX                  8
> > > > >  #define ACPI_NUM_MUTEX                  ACPI_MAX_MUTEX+1
> > > > >
> > > > >  /* Lock structure for reader/writer interfaces */
> > > > > diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
> > > > > index e114140..213fe1a 100644
> > > > > --- a/drivers/acpi/acpica/evxface.c
> > > > > +++ b/drivers/acpi/acpica/evxface.c
> > > > > @@ -495,6 +495,10 @@ acpi_install_notify_handler(acpi_handle device,
> > > > >  						handler, context,
> > > > >  						NULL);
> > > > >
> > > > > +		acpi_ut_acquire_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
> > > > > +
> > > > > +		notify_obj->common.reference_count = obj_desc->common.reference_count;
> > > > > +
> > > >
> > > > Should be converted to spin_lock here.
> > > >
> > >
> > > Did you mean using acpi_gbl_reference_count_lock ?
> >
> > Yes.
> >
> > >
> > > > >  		if (handler_type & ACPI_SYSTEM_NOTIFY) {
> > > > >  			obj_desc->common_notify.system_notify = notify_obj;
> > > > >  		}
> > > > > @@ -503,8 +507,9 @@ acpi_install_notify_handler(acpi_handle device,
> > > > >  			obj_desc->common_notify.device_notify = notify_obj;
> > > > >  		}
> > > > >
> > > > > -		if (handler_type == ACPI_ALL_NOTIFY) {
> > > > > +		acpi_ut_release_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
> > > > >
> > > > > +		if (handler_type == ACPI_ALL_NOTIFY) {
> > > > >  			/* Extra ref if installed in both */
> > > > >
> > > > >  			acpi_ut_add_reference(notify_obj);
> > > > > diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
> > > > > index 31f5a78..7559813 100644
> > > > > --- a/drivers/acpi/acpica/utdelete.c
> > > > > +++ b/drivers/acpi/acpica/utdelete.c
> > > > > @@ -504,6 +504,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
> > > > >
> > > > >  			/* Update the notify objects for these types (if present) */
> > > > >
> > > > > +			acpi_ut_acquire_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
> > >
> > > Can I acquire acpi_gbl_reference_count_lock here? Does is not cause recursive lock?
> > > Or direct acquire remove mutex here?
> >
> > You can.
> > If you just want to hold the lock longer, you can introduce a lockless API to replace the one invoked below.
> >
> 
> I just tried to change my mutex code to acquire acpi_gbl_reference_count_lock in acpi_ut_update_object_reference().
> But when system boot, kernel pending on updating ref_count of parent object, in acpi_ut_update_ref_count() when
> acquire acpi_gbl_reference_count_lock.
> 
> On the other hand,
> I didn't find lockless spinlock API in acpi subsystem, and even in acpica project git. Could you please help teach
> me where is the lockless function?
>

I agree this is not a suitable case for acpi_gbl_reference_count_lock usage.

I just want to say, this is an open source project, if you see any case need to extend the locking period, you can do any modification you want.
For example, if you find such a case: copying the reference from its original owner to a copy of the owner and try to increase it.
You can introduce an API to ensure atomicity by holding the acpi_gbl_reference_count_lock for the 2 operations.

> > >
> > > > >  			acpi_ut_update_ref_count(object->common_notify.
> > > > >  						 system_notify, action);
> > > >
> > > > If you take a look at acpi_ut_update_ref_count, there is already a spin_lock held around the code to update the reference count.
> > > >
> > > > Thanks
> > > > -Lv
> > >
> > > hm.... I am not sure can using acpi_gbl_reference_count_lock.
> > >
> > > When updating parent object's ref_count, it should atomic with its notify objects's ref_count updating.
> > > The situation I want to avoid is:
> > >
> > >  a. acpi_ut_update_object_reference() update ref_count of system_notify/device_notify. (Thermal driver)
> > >     Assume the notify object didn't install to parent object yet. So, the ref_count doesn't increase.
> > >
> > >  b. acpi_install_notify_handler() install system_notify/device_notify. (Processor driver)
> > >     Processor driver install notify handler of parent object in this window. The ref_count of notify object is 1.
> > >
> > >  c. acpi_ut_update_object_reference()  call acpi_ut_update_ref_count() to update ref_count of parent object. (Thermal driver)
> > >     The ref_count of parent object update to 2.
> > >     		<=== this ref_count doesn't match with ref_count of notify object, it's 1.
> > >
> > > Due to a. and c. steps should atomic, so I add ACPI_MTX_NOTIFY_REF_COUNT to bind them together, when
> > > the object type is processor, device, power or thermal.
> >
> > I can see that the only problem is the sub-object's reference count updates.
> > It shouldn't be increased each time the parent object's reference count is increased, but should be increased only once when it is
> linked to the parent object (referenced by the parent).
> > That seems to be the root cause.
> 
> Yes, this is the main problem, either increase or decrease ref_count of parent object, the sub-objects(here is notify object) will
> also updating either increase or decrease.
> 
> In the case of my issue machine, when ref_count of parent object is 2 but sub-object's ref_count is 1, later decrease parent object's
> ref_count to 0 will causes sub-object's ref_count is -1. <=== it triggers the double free issue then slab will emit oops.

Can I say that:
The issue is caused by the current ACPICA locking implementation.
For this case, we need 2 locks:
1. The first lock need to be used each time we are going to update the members of an object.
2. The second lock need to be used to mutual exclusively executing the code that can affect the object's state, ensure it is not messed up from different call context. This should be achieved by some artificial locking facility. In many cases, the call path is locked without holding any locks that can lead to an atomic context.

Currently we may just doing wrong by utilizing the 2nd lock to meet the 1st requirement.

For ACPICA, shall we first ask:
1. do we have a per-object lock to meet the first requirement?
2. do we have a global lock to protect the consistencies of the namespace?

I think you should fix this by tuning the locking granularity.
The patch can do so unless there is no other mean can be used to fix this issue.

Thanks and best regards
-Lv

> 
> > The current code might be a hackish result to work around some design defects.
> > So what you do in this patch might be dangerous, they can break ACPICA interpreter and you need to do it in the ACPICA source
> base.
> > There is a recursive unit test facility - ASLTS to help determine if your change doesn't introduce regressions.
> > I think you need to file a bug in ACPICA bugzilla and start a discussion there.
> >
> > Thanks and best regards
> > -Lv
> >
> 
> Thanks for your information, I will try ASLTS and file bug about the atomic between main object's ref_count
> with sub-object's ref_count.
> 
> > >
> > > >
> > > > >  			acpi_ut_update_ref_count(object->common_notify.
> > > > > @@ -592,6 +593,11 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
> > > > >  		 * main object to be deleted.
> > > > >  		 */
> > > > >  		acpi_ut_update_ref_count(object, action);
> > > > > +		if (object->common.type == ACPI_TYPE_PROCESSOR ||
> > > > > +		    object->common.type == ACPI_TYPE_DEVICE ||
> > > > > +		    object->common.type == ACPI_TYPE_POWER ||
> > > > > +		    object->common.type == ACPI_TYPE_THERMAL)
> > > > > +			acpi_ut_release_mutex(ACPI_MTX_NOTIFY_REF_COUNT);
> > >
> > > here also. I think need remove this release?
> > >
> > > > >  		object = NULL;
> > > > >
> > > > >  		/* Move on to the next object to be updated */
> > > > > --
> > > > > 1.8.4.5
> > > >
> > >
> > > Please let me know if I miss understood.
> > >
> > >
> > > Thanks a lot!
> > > Joey Lee
> 
> Regards
> Joey Lee
