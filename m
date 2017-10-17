From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v4 2/2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Tue, 17 Oct 2017 18:34:05 +0800
Message-ID: <ac14fb7e-3652-d8c7-db7b-1415206cb563@huawei.com>
References: <201710171855.3EaG64M1%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8468 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933304AbdJQKej (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Oct 2017 06:34:39 -0400
In-Reply-To: <201710171855.3EaG64M1%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, bp@suse.de, tbaicar@codeaurora.org, james.morse@arm.com, zjzhang@codeaurora.org, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

Have fixed it in the patch v5.

On 2017/10/17 18:20, kbuild test robot wrote:
> Hi Dongjiu,
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.14-rc5 next-20171016]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/acpi-apei-remove-the-unused-dead-code-for-SEA-NMI-notification-type/20171017-141237
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: x86_64-kexec (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/apei/ghes.c: In function 'ghes_probe':
>>> drivers/acpi/apei/ghes.c:1191:3: error: implicit declaration of function 'ghes_abort_add' [-Werror=implicit-function-declaration]
>       ghes_abort_add(ghes);
>       ^~~~~~~~~~~~~~
>    drivers/acpi/apei/ghes.c: In function 'ghes_remove':
>>> drivers/acpi/apei/ghes.c:1245:3: error: implicit declaration of function 'ghes_abort_remove' [-Werror=implicit-function-declaration]
>       ghes_abort_remove(ghes);
>       ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/ghes_abort_add +1191 drivers/acpi/apei/ghes.c
> 
>   1085	
>   1086	static int ghes_probe(struct platform_device *ghes_dev)
>   1087	{
>   1088		struct acpi_hest_generic *generic;
>   1089		struct ghes *ghes = NULL;
>   1090	
>   1091		int rc = -EINVAL;
>   1092	
>   1093		generic = *(struct acpi_hest_generic **)ghes_dev->dev.platform_data;
>   1094		if (!generic->enabled)
>   1095			return -ENODEV;
>   1096	
>   1097		switch (generic->notify.type) {
>   1098		case ACPI_HEST_NOTIFY_POLLED:
>   1099		case ACPI_HEST_NOTIFY_EXTERNAL:
>   1100		case ACPI_HEST_NOTIFY_SCI:
>   1101		case ACPI_HEST_NOTIFY_GSIV:
>   1102		case ACPI_HEST_NOTIFY_GPIO:
>   1103			break;
>   1104	
>   1105		case ACPI_HEST_NOTIFY_SEA:
>   1106			if (!IS_ENABLED(CONFIG_ACPI_APEI_SEA)) {
>   1107				pr_warn(GHES_PFX "Generic hardware error source: %d notified via SEA is not supported\n",
>   1108					generic->header.source_id);
>   1109				rc = -ENOTSUPP;
>   1110				goto err;
>   1111			}
>   1112			break;
>   1113		case ACPI_HEST_NOTIFY_SEI:
>   1114			if (!IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
>   1115				pr_warn(GHES_PFX "Generic hardware error source: %d notified via SEI is not supported!\n",
>   1116					generic->header.source_id);
>   1117			goto err;
>   1118		}
>   1119		break;
>   1120		case ACPI_HEST_NOTIFY_NMI:
>   1121			if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
>   1122				pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
>   1123					generic->header.source_id);
>   1124				goto err;
>   1125			}
>   1126			break;
>   1127		case ACPI_HEST_NOTIFY_LOCAL:
>   1128			pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
>   1129				   generic->header.source_id);
>   1130			goto err;
>   1131		default:
>   1132			pr_warning(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
>   1133				   generic->notify.type, generic->header.source_id);
>   1134			goto err;
>   1135		}
>   1136	
>   1137		rc = -EIO;
>   1138		if (generic->error_block_length <
>   1139		    sizeof(struct acpi_hest_generic_status)) {
>   1140			pr_warning(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
>   1141				   generic->error_block_length,
>   1142				   generic->header.source_id);
>   1143			goto err;
>   1144		}
>   1145		ghes = ghes_new(generic);
>   1146		if (IS_ERR(ghes)) {
>   1147			rc = PTR_ERR(ghes);
>   1148			ghes = NULL;
>   1149			goto err;
>   1150		}
>   1151	
>   1152		rc = ghes_edac_register(ghes, &ghes_dev->dev);
>   1153		if (rc < 0)
>   1154			goto err;
>   1155	
>   1156		switch (generic->notify.type) {
>   1157		case ACPI_HEST_NOTIFY_POLLED:
>   1158			setup_deferrable_timer(&ghes->timer, ghes_poll_func,
>   1159					       (unsigned long)ghes);
>   1160			ghes_add_timer(ghes);
>   1161			break;
>   1162		case ACPI_HEST_NOTIFY_EXTERNAL:
>   1163			/* External interrupt vector is GSI */
>   1164			rc = acpi_gsi_to_irq(generic->notify.vector, &ghes->irq);
>   1165			if (rc) {
>   1166				pr_err(GHES_PFX "Failed to map GSI to IRQ for generic hardware error source: %d\n",
>   1167				       generic->header.source_id);
>   1168				goto err_edac_unreg;
>   1169			}
>   1170			rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED,
>   1171					 "GHES IRQ", ghes);
>   1172			if (rc) {
>   1173				pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
>   1174				       generic->header.source_id);
>   1175				goto err_edac_unreg;
>   1176			}
>   1177			break;
>   1178	
>   1179		case ACPI_HEST_NOTIFY_SCI:
>   1180		case ACPI_HEST_NOTIFY_GSIV:
>   1181		case ACPI_HEST_NOTIFY_GPIO:
>   1182			mutex_lock(&ghes_list_mutex);
>   1183			if (list_empty(&ghes_hed))
>   1184				register_acpi_hed_notifier(&ghes_notifier_hed);
>   1185			list_add_rcu(&ghes->list, &ghes_hed);
>   1186			mutex_unlock(&ghes_list_mutex);
>   1187			break;
>   1188	
>   1189		case ACPI_HEST_NOTIFY_SEA:
>   1190		case ACPI_HEST_NOTIFY_SEI:
>> 1191			ghes_abort_add(ghes);
>   1192			break;
>   1193		case ACPI_HEST_NOTIFY_NMI:
>   1194			ghes_nmi_add(ghes);
>   1195			break;
>   1196		default:
>   1197			BUG();
>   1198		}
>   1199		platform_set_drvdata(ghes_dev, ghes);
>   1200	
>   1201		/* Handle any pending errors right away */
>   1202		ghes_proc(ghes);
>   1203	
>   1204		return 0;
>   1205	err_edac_unreg:
>   1206		ghes_edac_unregister(ghes);
>   1207	err:
>   1208		if (ghes) {
>   1209			ghes_fini(ghes);
>   1210			kfree(ghes);
>   1211		}
>   1212		return rc;
>   1213	}
>   1214	
>   1215	static int ghes_remove(struct platform_device *ghes_dev)
>   1216	{
>   1217		struct ghes *ghes;
>   1218		struct acpi_hest_generic *generic;
>   1219	
>   1220		ghes = platform_get_drvdata(ghes_dev);
>   1221		generic = ghes->generic;
>   1222	
>   1223		ghes->flags |= GHES_EXITING;
>   1224		switch (generic->notify.type) {
>   1225		case ACPI_HEST_NOTIFY_POLLED:
>   1226			del_timer_sync(&ghes->timer);
>   1227			break;
>   1228		case ACPI_HEST_NOTIFY_EXTERNAL:
>   1229			free_irq(ghes->irq, ghes);
>   1230			break;
>   1231	
>   1232		case ACPI_HEST_NOTIFY_SCI:
>   1233		case ACPI_HEST_NOTIFY_GSIV:
>   1234		case ACPI_HEST_NOTIFY_GPIO:
>   1235			mutex_lock(&ghes_list_mutex);
>   1236			list_del_rcu(&ghes->list);
>   1237			if (list_empty(&ghes_hed))
>   1238				unregister_acpi_hed_notifier(&ghes_notifier_hed);
>   1239			mutex_unlock(&ghes_list_mutex);
>   1240			synchronize_rcu();
>   1241			break;
>   1242	
>   1243		case ACPI_HEST_NOTIFY_SEA:
>   1244		case ACPI_HEST_NOTIFY_SEI:
>> 1245			ghes_abort_remove(ghes);
>   1246			break;
>   1247		case ACPI_HEST_NOTIFY_NMI:
>   1248			ghes_nmi_remove(ghes);
>   1249			break;
>   1250		default:
>   1251			BUG();
>   1252			break;
>   1253		}
>   1254	
>   1255		ghes_fini(ghes);
>   1256	
>   1257		ghes_edac_unregister(ghes);
>   1258	
>   1259		kfree(ghes);
>   1260	
>   1261		platform_set_drvdata(ghes_dev, NULL);
>   1262	
>   1263		return 0;
>   1264	}
>   1265	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

