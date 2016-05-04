From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/15] ACPICA: Linuxize: reduce divergences for 20160422 release
Date: Wed, 04 May 2016 23:38:44 +0200
Message-ID: <3228917.WSuD8YVc96@vostro.rjw.lan>
References: <cover.1462331120.git.lv.zheng@intel.com> <eb15d96bad1b4dd98f24fc249c8a540d0469cb7b.1462331121.git.lv.zheng@intel.com> <3430757.oQjUZYhhVi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65202 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752702AbcEDVfd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2016 17:35:33 -0400
In-Reply-To: <3430757.oQjUZYhhVi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, May 04, 2016 11:37:51 PM Rafael J. Wysocki wrote:
> On Wednesday, May 04, 2016 01:48:07 PM Lv Zheng wrote:
> > The patch reduces source code differences between the Linux kernel and the
> > ACPICA upstream so that the linuxized ACPICA 20160422 release can be
> > applied with reduced human intervention.
> > 
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> 
> Like previously, this adds white space where it shouldn't.
> 
> > ---
> >  drivers/acpi/acpica/aclocal.h  |    2 +-
> >  drivers/acpi/acpica/acresrc.h  |    2 +-
> >  drivers/acpi/acpica/actables.h |    2 +-
> >  drivers/acpi/acpica/dsfield.c  |    4 ++--
> >  drivers/acpi/acpica/dswstate.c |    2 +-
> >  drivers/acpi/acpica/exconfig.c |    2 +-
> >  drivers/acpi/acpica/exregion.c |    2 +-
> >  drivers/acpi/acpica/exresop.c  |    2 +-
> >  drivers/acpi/acpica/hwgpe.c    |   10 +++++-----
> >  drivers/acpi/acpica/hwregs.c   |    4 ++--
> >  drivers/acpi/acpica/hwxface.c  |    2 +-
> >  drivers/acpi/acpica/nspredef.c |    2 +-
> >  drivers/acpi/acpica/nsxfname.c |    2 +-
> >  drivers/acpi/acpica/rscalc.c   |    2 +-
> >  drivers/acpi/acpica/tbxface.c  |    2 +-
> >  drivers/acpi/acpica/utcopy.c   |    8 ++++----
> >  drivers/acpi/acpica/utlock.c   |    4 ++--
> >  drivers/acpi/acpica/utmath.c   |    4 ++--
> >  include/acpi/acpiosxf.h        |    2 +-
> >  19 files changed, 30 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> > index 083b16a..379797e 100644
> > --- a/drivers/acpi/acpica/aclocal.h
> > +++ b/drivers/acpi/acpica/aclocal.h
> > @@ -541,7 +541,7 @@ struct acpi_gpe_device_info {
> >  
> >  typedef acpi_status(*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *
> >  					 gpe_xrupt_info,
> > -					 struct acpi_gpe_block_info *gpe_block,
> > +					 struct acpi_gpe_block_info * gpe_block,
> >  					 void *context);
> 
> No, please don't add that white space.
> 
> >  /* Information about each particular fixed event */
> > diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
> > index 83e9a29..baacde8 100644
> > --- a/drivers/acpi/acpica/acresrc.h
> > +++ b/drivers/acpi/acpica/acresrc.h
> > @@ -223,7 +223,7 @@ acpi_rs_get_aei_method_data(struct acpi_namespace_node *node,
> >   * rscalc
> >   */
> >  acpi_status
> > -acpi_rs_get_list_length(u8 * aml_buffer,
> > +acpi_rs_get_list_length(u8 *aml_buffer,
> >  			u32 aml_buffer_length, acpi_size * size_needed);
> 
> Why do you fix one and not the other?
> 
> >  
> >  acpi_status
> > diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
> > index 848ad3a..fa81099 100644
> > --- a/drivers/acpi/acpica/actables.h
> > +++ b/drivers/acpi/acpica/actables.h
> > @@ -131,7 +131,7 @@ acpi_status acpi_tb_allocate_owner_id(u32 table_index);
> >  
> >  acpi_status acpi_tb_release_owner_id(u32 table_index);
> >  
> > -acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id);
> > +acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id * owner_id);
> 
> The added white space does not adhere to the kernel coding style.
> 
> >  /*
> >   * tbutils - table manager utilities
> > diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
> > index 6a4b603..0cd777f 100644
> > --- a/drivers/acpi/acpica/dsfield.c
> > +++ b/drivers/acpi/acpica/dsfield.c
> > @@ -147,8 +147,8 @@ acpi_ds_create_external_region(acpi_status lookup_status,
> >   ******************************************************************************/
> >  
> >  acpi_status
> > -acpi_ds_create_buffer_field(union acpi_parse_object *op,
> > -			    struct acpi_walk_state *walk_state)
> > +acpi_ds_create_buffer_field(union acpi_parse_object * op,
> > +			    struct acpi_walk_state * walk_state)
> 
> Same here.
> 
> >  {
> >  	union acpi_parse_object *arg;
> >  	struct acpi_namespace_node *node;
> > diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
> > index 3a26ddb..6ec8dca 100644
> > --- a/drivers/acpi/acpica/dswstate.c
> > +++ b/drivers/acpi/acpica/dswstate.c
> > @@ -143,7 +143,7 @@ acpi_ds_result_pop(union acpi_operand_object **object,
> >   ******************************************************************************/
> >  
> >  acpi_status
> > -acpi_ds_result_push(union acpi_operand_object * object,
> > +acpi_ds_result_push(union acpi_operand_object *object,
> >  		    struct acpi_walk_state * walk_state)
> 
> Why do you fix one and not the other?
> 
> >  {
> >  	union acpi_generic_state *state;
> > diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
> > index a1d177d..03d2eb0 100644
> > --- a/drivers/acpi/acpica/exconfig.c
> > +++ b/drivers/acpi/acpica/exconfig.c
> > @@ -334,7 +334,7 @@ acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
> >  acpi_status
> >  acpi_ex_load_op(union acpi_operand_object *obj_desc,
> >  		union acpi_operand_object *target,
> > -		struct acpi_walk_state *walk_state)
> > +		struct acpi_walk_state * walk_state)
> 
> More damaged white space.
> 
> >  {
> >  	union acpi_operand_object *ddb_handle;
> >  	struct acpi_table_header *table_header;
> > diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> > index 076074d..3bcea59 100644
> > --- a/drivers/acpi/acpica/exregion.c
> > +++ b/drivers/acpi/acpica/exregion.c
> > @@ -333,7 +333,7 @@ acpi_ex_system_io_space_handler(u32 function,
> >  	case ACPI_WRITE:
> >  
> >  		status = acpi_hw_write_port((acpi_io_address) address,
> > -					    (u32) * value, bit_width);
> > +					    (u32)*value, bit_width);
> >  		break;
> >  
> >  	default:
> > diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
> > index cc2c26c..da6bf0e 100644
> > --- a/drivers/acpi/acpica/exresop.c
> > +++ b/drivers/acpi/acpica/exresop.c
> > @@ -131,7 +131,7 @@ acpi_ex_check_object_type(acpi_object_type type_needed,
> >  
> >  acpi_status
> >  acpi_ex_resolve_operands(u16 opcode,
> > -			 union acpi_operand_object ** stack_ptr,
> > +			 union acpi_operand_object **stack_ptr,
> >  			 struct acpi_walk_state * walk_state)
> 
> Why do you fix one and not the other?
> 
> >  {
> >  	union acpi_operand_object *obj_desc;
> > diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> > index 1c4f451..8cc5cc0 100644
> > --- a/drivers/acpi/acpica/hwgpe.c
> > +++ b/drivers/acpi/acpica/hwgpe.c
> > @@ -315,8 +315,8 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
> >   ******************************************************************************/
> >  
> >  acpi_status
> > -acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
> > -			  struct acpi_gpe_block_info *gpe_block, void *context)
> > +acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
> > +			  struct acpi_gpe_block_info * gpe_block, void *context)
> 
> More damaged white space.
> 
> And analogously below.
> 
> I'm assuming that the rest of the series won't apply without this patch,
> so I'm not going to try to apply it.
> 
> Please revise and resend.

Of course, patch [8/15] has been applied already, so no need to resend it.

Thanks,
Rafael

