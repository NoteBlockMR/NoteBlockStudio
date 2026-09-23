function get_mode_actions(argument0) {
	// get_mode_actions(num)
	// Returns the correct action name according to the currently selected edit mode

	var num = argument0

	if (language != 1) switch editmode {
		case m_key: {
			switch num {
				case 1: return localize_ko("Transpose one octave up") break
				case 2: return localize_ko("Transpose one octave down") break
				case 3: return localize_ko("Transpose up") break
				case 4: return localize_ko("Transpose down") break
				default: return ""
			}
			break
		}
		case m_vel: {
			switch num {
				case 1: return localize_ko("Increase velocity by 10") break
				case 2: return localize_ko("Decrease velocity by 10") break
				case 3: return localize_ko("Increase velocity") break
				case 4: return localize_ko("Decrease velocity") break
				case 5: return localize_ko("Set velocity...") break
				case 6: return localize_ko("Reset velocity") break
				default: return ""
			}
			break
		}
		case m_pan: {
			switch num {
				case 1: return localize_ko("Pan right by 10") break
				case 2: return localize_ko("Pan left by 10") break
				case 3: return localize_ko("Pan right") break
				case 4: return localize_ko("Pan left") break
				case 5: return localize_ko("Set panning...") break
				case 6: return localize_ko("Reset panning") break
				default: return ""
			}
			break
		}
		case m_pit: {
			switch num {
				case 1: return localize_ko("Detune +10 cents") break
				case 2: return localize_ko("Detune -10 cents") break
				case 3: return localize_ko("Detune +1 cent") break
				case 4: return localize_ko("Detune -1 cent") break
				case 5: return localize_ko("Set pitch...") break
				case 6: return localize_ko("Reset pitch") break
				default: return ""
			}
			break
		}
	}
	else switch editmode {
		case m_key: {
			switch num {
				case 1: return "升八度" break
				case 2: return "降八度" break
				case 3: return "升半音" break
				case 4: return "降半音" break
				default: return ""
			}
			break
		}
		case m_vel: {
			switch num {
				case 1: return "增加 10 音量" break
				case 2: return "减小 10 音量" break
				case 3: return "增加音量" break
				case 4: return "减小音量" break
				case 5: return "设定音量……" break
				case 6: return "重置音量" break
				default: return ""
			}
			break
		}
		case m_pan: {
			switch num {
				case 1: return "向右声道移动 10" break
				case 2: return "向左声道移动 10" break
				case 3: return "向右声道移动" break
				case 4: return "向左声道移动" break
				case 5: return "设定音符声道……" break
				case 6: return "重置立体声" break
				default: return ""
			}
			break
		}
		case m_pit: {
			switch num {
				case 1: return "上调 10 微分" break
				case 2: return "下调 10 微分" break
				case 3: return "上调 1 微分" break
				case 4: return "下调 1 微分" break
				case 5: return "设定音高……" break
				case 6: return "重置音高" break
				default: return ""
			}
			break
		}
	}


}
